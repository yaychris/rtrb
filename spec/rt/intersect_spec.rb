describe Intersection do
  describe '#new' do
    let(:sphere) { Sphere.new }

    subject { Intersection.new(3.5, sphere) }

    it 'returns the intersection' do
      expect(subject.t).to eq(3.5)
      expect(subject.object).to eq(sphere)
    end
  end

  describe '#prepare' do
    context 'intersection is outside' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }
      let(:shape) { Sphere.new }

      subject { Intersection.new(4, shape) }

      it 'precomputes the things' do
        subject.prepare(ray)

        expect(subject.inside?).to be(false)
        expect(subject.t).to eq(4)
        expect(subject.object).to eq(shape)
        expect(subject.point).to eq(Point(0, 0, -1))
        expect(subject.eye_v).to eq(Vector(0, 0, -1))
        expect(subject.normal_v).to eq(Vector(0, 0, -1))
      end
    end

    context 'intersection is inside' do
      let(:ray) { Ray.new(Point(0, 0, 0), Vector(0, 0, 1)) }
      let(:shape) { Sphere.new }

      subject { Intersection.new(1, shape) }

      it 'precomputes the things' do
        subject.prepare(ray)

        expect(subject.inside?).to be(true)
        expect(subject.t).to eq(1)
        expect(subject.object).to eq(shape)
        expect(subject.point).to eq(Point(0, 0, 1))
        expect(subject.eye_v).to eq(Vector(0, 0, -1))
        expect(subject.normal_v).to eq(Vector(0, 0, -1))
      end
    end
  end
end
