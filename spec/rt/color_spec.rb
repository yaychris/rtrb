describe Color do
  describe '#new' do
    subject { Color.new(-0.5, 0.4, 1.7) }

    it 'returns a new color' do
      expect(subject.r).to equal(-0.5)
      expect(subject.red).to equal(-0.5)

      expect(subject.g).to equal(0.4)
      expect(subject.green).to equal(0.4)

      expect(subject.b).to equal(1.7)
      expect(subject.blue).to equal(1.7)
    end
  end

  describe 'addition' do
    let(:a) { Color.new(0.9, 0.6, 0.75) }
    let(:b) { Color.new(0.7, 0.1, 0.25) }

    it 'adds and returns a new color' do
      expect(a + b).to eq(Color.new(1.6, 0.7, 1.0))
    end
  end

  describe 'subtraction' do
    let(:a) { Color.new(1.0, 0.6, 0.75) }
    let(:b) { Color.new(1.0, 0.1, 0.25) }

    it 'subtracts and returns a new color' do
      expect(a - b).to eq(Color.new(0.0, 0.5, 0.5))
    end
  end

  describe 'scalar multiplication' do
    subject { Color.new(0.2, 0.3, 0.4) }

    it 'scales and returns a new color' do
      expect(subject * 2).to eq(Color.new(0.4, 0.6, 0.8))
    end
  end

  describe 'color multiplication' do
    let(:a) { Color.new(1.0, 0.2, 0.5) }
    let(:b) { Color.new(0.9, 1.0, 0.2) }

    it 'multiplies and returns a new color' do
      expect(a * b).to eq(Color.new(0.9, 0.2, 0.1))
    end
  end

  describe '#to_a' do
    subject { Color.new(0, 0.5, 1.0) }

    it 'returns a color array' do
      expect(subject.to_a).to eq([0.0, 0.5, 1.0])
    end
  end

  describe '#to_ppm' do
    subject { Color.new(-0.5, 0.5, 1.5) }

    it 'returns the correct RGB value' do
      expect(subject.to_ppm).to eq([0, 128, 255])
    end
  end
end
