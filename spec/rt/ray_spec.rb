describe Ray do
  subject { Ray.new(origin, direction) }

  describe '#new' do
    let(:origin) { Point(1, 2, 3) }
    let(:direction) { Vector(4, 5, 6) }

    it 'returns a new ray' do
      expect(subject.origin).to eq(origin)
      expect(subject.direction).to eq(direction)
    end
  end

  describe '#position' do
    let(:origin) { Point(2, 3, 4) }
    let(:direction) { Vector(1, 0, 0) }

    it 'returns the point along the ray' do
      expect(subject.position(0)).to eq(Point(2, 3, 4))
      expect(subject.position(1)).to eq(Point(3, 3, 4))
      expect(subject.position(-1)).to eq(Point(1, 3, 4))
      expect(subject.position(2.5)).to eq(Point(4.5, 3, 4))
    end
  end

  describe '#transform' do
    let(:r) { Ray.new(Point(1, 2, 3), Vector(0, 1, 0)) }

    context 'translating' do
      let(:m) { Matrix.translation(3, 4, 5) }

      subject { r.transform(m) }

      it 'returns a translated ray' do
        expect(subject.origin).to eq(Point(4, 6, 8))
        expect(subject.direction).to eq(Vector(0, 1, 0))
      end
    end

    context 'scaling' do
      let(:m) { Matrix.scaling(2, 3, 4) }

      subject { r.transform(m) }

      it 'returns a translated ray' do
        expect(subject.origin).to eq(Point(2, 6, 12))
        expect(subject.direction).to eq(Vector(0, 3, 0))
      end
    end
  end
end
