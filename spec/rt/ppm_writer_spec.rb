# import { Canvas } from './canvas'
# import { CanvasPPM } from './canvas_ppm'
# import { color } from './color'

describe PPMWriter do
  let(:canvas) { Canvas.new(5, 3) }

  subject { PPMWriter.new(canvas) }

  describe '#header_lines' do
    it 'returns the header lines' do
      expect(subject.header_lines).to eq(['P3', '5 3', '255'])
    end
  end

  describe '#write' do
    data = <<-END
P3
5 3
255
255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
END
    it 'writes the correct pixel data' do
      canvas[0, 0] = Color.new(1.5, 0, 0)
      canvas[2, 1] = Color.new(0, 0.5, 0)
      canvas[4, 2] = Color.new(-0.5, 0, 1)

      expect(subject.write).to eq(data)
    end

    it 'breaks lines at 70 characters' do
      data = <<-END
P3
10 2
255
255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
153 255 204 153 255 204 153 255 204 153 255 204 153
255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
153 255 204 153 255 204 153 255 204 153 255 204 153
END
      
      canvas = Canvas.new(10, 2)
      subject = PPMWriter.new(canvas)

      canvas.each do |x, y|
        canvas[x, y] = Color.new(1, 0.8, 0.6)
      end

      expect(subject.write).to eq(data)
    end

    it 'ends with a newline' do
      expect(subject.write.slice(-1)).to eq("\n")
    end
  end
end
