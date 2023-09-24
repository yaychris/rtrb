describe Sphere do
  subject { Sphere.new }

  describe '#initialize' do
    it 'returns a default sphere' do
      expect(subject.origin).to eq(Point(0, 0, 0))
      expect(subject.radius).to eq(1.0)
      expect(subject.transform).to eq(Matrix.identity)
    end
  end

  describe '#transform=' do
    let(:m) { Matrix.translation(2, 3, 4) }

    it 'sets the transform' do
      subject.transform = m

      expect(subject.transform).to eq(m)
    end
  end

  describe '#intersect' do
    let(:sphere) { Sphere.new }

    subject { sphere.intersect(ray) }

    context 'return values' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

      it 'returns the position and object' do
        expect(subject[0].t).to eq(4.0)
        expect(subject[0].object).to eq(sphere)
        expect(subject[1].t).to eq(6.0)
        expect(subject[1].object).to eq(sphere)
      end
    end

    context 'two points' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

      it 'returns two intersections' do
        expect(subject[0].t).to eq(4.0)
        expect(subject[1].t).to eq(6.0)
      end
    end

    context 'tangent' do
      let(:ray) { Ray.new(Point(0, 1, -5), Vector(0, 0, 1)) }

      it 'returns two intersections with the same t' do
        expect(subject[0].t).to eq(5.0)
        expect(subject[1].t).to eq(5.0)
      end
    end

    context 'misses' do
      let(:ray) { Ray.new(Point(0, 2, -5), Vector(0, 0, 1)) }

      it 'returns zero intersections' do
        expect(subject).to eq([])
      end
    end

    context 'ray originates inside sphere' do
      let(:ray) { Ray.new(Point(0, 0, 0), Vector(0, 0, 1)) }

      it 'returns two intersections' do
        expect(subject[0].t).to eq(-1.0)
        expect(subject[1].t).to eq(1.0)
      end
    end

    context 'ray originates in front of sphere' do
      let(:ray) { Ray.new(Point(0, 0, 5), Vector(0, 0, 1)) }

      it 'returns two intersections' do
        expect(subject[0].t).to eq(-6.0)
        expect(subject[1].t).to eq(-4.0)
      end
    end

    context 'scaled sphere' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

      before { sphere.transform = Matrix.scaling(2, 2, 2) }

      it 'returns two intersections' do
        expect(subject[0].t).to eq(3)
        expect(subject[1].t).to eq(7)
      end
    end

    context 'translated sphere' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

      before { sphere.transform = Matrix.translation(5, 0, 0) }

      it 'returns two intersections' do
        expect(subject.count).to eq(0)
      end
    end
  end
end
