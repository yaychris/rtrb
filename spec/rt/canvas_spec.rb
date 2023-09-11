describe Canvas do
  let(:black) { Color::BLACK }
  let(:red)   { Color.new(1.0, 0, 0) }

  describe '#new' do
    subject { Canvas.new(10, 20) }

    it 'returns a new canvas' do
      expect(subject.width).to be(10)
      expect(subject.height).to be(20)

      subject.each do |color, _, _|
        expect(color).to eq(black)
      end
    end
  end

  describe 'reading and writing data' do
    subject { Canvas.new(2, 2) }

    before do
      subject[1, 1] = red
    end

    it 'reads the data correctly' do
      expect(subject[0, 0]).to eq(black)
      expect(subject[0, 1]).to eq(black)
      expect(subject[1, 0]).to eq(black)
      expect(subject[1, 1]).to eq(red)
    end
  end
end
