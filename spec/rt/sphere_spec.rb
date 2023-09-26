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

  describe '#material=' do
    let(:material) { Material.new }

    it 'sets the material' do
      material.ambient = 1
      subject.material = material

      expect(subject.material.ambient).to eq(1)
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

  describe '#normal_at' do
    let(:sqrt3) { Math.sqrt(3) / 3 }

    subject { Sphere.new }

    context 'returned normal' do
      let(:p) { Point(sqrt3, sqrt3, sqrt3) }

      it 'is normalized' do
        n = subject.normal_at(p)

        expect(n.normalize).to eq(n)
      end
    end

    context 'point on x axis' do
      let(:p) { Point(1, 0, 0) }

      it 'returns the normal' do
        expect(subject.normal_at(p)).to eq(Vector(1, 0, 0))
      end
    end

    context 'point on y axis' do
      let(:p) { Point(0, 1, 0) }

      it 'returns the normal' do
        expect(subject.normal_at(p)).to eq(Vector(0, 1, 0))
      end
    end

    context 'point on z axis' do
      let(:p) { Point(0, 0, 1) }

      it 'returns the normal' do
        expect(subject.normal_at(p)).to eq(Vector(0, 0, 1))
      end
    end

    context 'nonaxial point' do
      let(:p) { Point(sqrt3, sqrt3, sqrt3) }

      it 'returns the normal' do
        expect(subject.normal_at(p)).to eq(Vector(sqrt3, sqrt3, sqrt3))
      end
    end

    context 'translated sphere' do
      let(:p) { Point(0, 1.70711, -0.70711) }

      before do
        subject.transform = Matrix.translation(0, 1, 0)
      end

      it 'returns the normal' do
        expect(subject.normal_at(p)).to fixed_eq(Vector(0, 0.70711, -0.70711))
      end
    end

    context 'transformed sphere' do
      let(:sqrt2) { Math.sqrt(2) / 2 }
      let(:p) { Point(0, sqrt2, -sqrt2) }

      before do
        subject.transform = Matrix.scaling(1, 0.5, 1) * Matrix.rotation_z(Math::PI / 5)
      end

      it 'returns the normal' do
        expect(subject.normal_at(p)).to fixed_eq(Vector(0, 0.97014, -0.24254))
      end
    end
  end
end
