describe World do
  describe '.default' do
    let(:light) { PointLight.new(Point(-10, 10, -10), Color.white) }

    let(:sphere1) do
      s = Sphere.new
      s.material.color = Color.new(0.8, 1.0, 0.6)
      s.material.diffuse = 0.7
      s.material.specular = 0.2
      s
    end

    let(:sphere2) do
      s = Sphere.new
      s.transform = Matrix.scaling(0.5, 0.5, 0.5)
      s
    end

    subject { World.default }

    it 'returns the default world' do
      expect(subject.objects).to contain_exactly(sphere1, sphere2)
      expect(subject.light).to eq(light)
    end
  end

  describe '#new' do
    subject { World.new }

    it 'returns a new, empty world' do
      expect(subject.objects).to eq([])
      expect(subject.light).to be_nil
    end
  end

  describe '#intersect' do
    subject { World.default }

    let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

    it 'returns the intersections, sorted' do
      xs = subject.intersect(ray)

      expect(xs.count).to eq(4)
      expect(xs[0].t).to eq(4)
      expect(xs[1].t).to eq(4.5)
      expect(xs[2].t).to eq(5.5)
      expect(xs[3].t).to eq(6)
    end
  end

  describe '#shade' do
    subject { World.default }

    context 'from the outside' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }
      let(:shape) { subject.objects.first }
      let(:intersection) { Intersection.new(4, shape) }

      it 'returns the correct color' do
        intersection.prepare(ray)
        color = subject.shade(intersection)

        expect(color).to fixed_eq(Color.new(0.38066, 0.47583, 0.2855))
      end
    end

    context 'from the inside' do
      let(:light) { PointLight.new(Point(0, 0.25, 0), Color.white) }
      let(:ray) { Ray.new(Point(0, 0, 0), Vector(0, 0, 1)) }
      let(:shape) { subject.objects[1] }
      let(:intersection) { Intersection.new(0.5, shape) }

      before do
        subject.light = PointLight.new(Point(0, 0.25, 0), Color.white)
      end

      it 'returns the correct color' do
        intersection.prepare(ray)
        color = subject.shade(intersection)

        expect(color).to fixed_eq(Color.new(0.90498, 0.90498, 0.90498))
      end
    end
  end

  describe '#color_at' do
    subject { World.default }

    context 'ray misses' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 1, 0)) }

      it 'returns black' do
        expect(subject.color_at(ray)).to eq(Color.black)
      end
    end

    context 'ray hits' do
      let(:ray) { Ray.new(Point(0, 0, -5), Vector(0, 0, 1)) }

      it 'returns the color' do
        expect(subject.color_at(ray)).to fixed_eq(Color.new(0.38066, 0.47583, 0.2855))
      end
    end

    context 'intersection hits behind the ray' do
      let(:outer) { subject.objects[0] }
      let(:inner) { subject.objects[1] }
      let(:ray) { Ray.new(Point(0, 0, 0.75), Vector(0, 0, -1)) }

      before do
        outer.material.ambient = 1
        inner.material.ambient = 1
      end

      it 'returns the inner sphere color' do
        expect(subject.color_at(ray)).to fixed_eq(inner.material.color)
      end
    end
  end
end
