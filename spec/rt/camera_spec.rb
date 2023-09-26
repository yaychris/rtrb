describe Camera do
  let(:fov) { Math::PI / 2 }

  describe '#initialize' do
    context 'creating a camera' do
      subject { Camera.new(160, 120, fov) }

      it 'sets the attributes' do
        expect(subject.hsize).to eq(160)
        expect(subject.vsize).to eq(120)
        expect(subject.fov).to eq(Math::PI / 2)
        expect(subject.transform).to eq(Matrix.identity)
      end
    end

    context 'calculating the pixel size' do
      context 'horizontal camera' do
        subject { Camera.new(200, 125, fov) }

        it 'sets the correct pixel size' do
          expect(subject.pixel_size).to fixed_eq(0.01)
        end
      end

      context 'vertical camera' do
        subject { Camera.new(125, 200, fov) }

        it 'sets the correct pixel size' do
          expect(subject.pixel_size).to fixed_eq(0.01)
        end
      end
    end
  end

  describe '#ray_for_pixel' do
    subject { Camera.new(201, 101, fov) }

    context 'through the center of the canvas' do
      it 'returns the ray through the pixel' do
        ray = subject.ray_for_pixel(100, 50)

        expect(ray.origin).to fixed_eq(Point(0, 0, 0))
        expect(ray.direction).to fixed_eq(Vector(0, 0, -1))
      end
    end

    context 'through a corner of the canvas' do
      it 'returns the ray through the pixel' do
        ray = subject.ray_for_pixel(0, 0)

        expect(ray.origin).to fixed_eq(Point(0, 0, 0))
        expect(ray.direction).to fixed_eq(Vector(0.66519, 0.33259, -0.66851))
      end
    end

    context 'when the camera is transformed' do
      let(:sqrt2) { Math.sqrt(2) }
      let(:transform) { Matrix.rotation_y(Math::PI / 4) * Matrix.translation(0, -2, 5) }

      it 'returns the ray through the pixel' do
        subject.transform = transform

        ray = subject.ray_for_pixel(100, 50)

        expect(ray.origin).to fixed_eq(Point(0, 2, -5))
        expect(ray.direction).to fixed_eq(Vector(sqrt2 / 2, 0, -sqrt2 / 2))
      end
    end
  end

  describe '#render' do
    subject { Camera.new(11, 11, Math::PI / 2) }

    let(:world) { World.default }
    let(:from) { Point(0, 0, -5) }
    let(:to) { Point(0, 0, 0) }
    let(:up) { Vector(0, 1, 0) }
    let(:transform) { view_transform(from, to, up) }

    it 'returns a canvas' do
      subject.transform = transform

      canvas = subject.render(world)
      expect(canvas[5, 5]).to fixed_eq(Color.new(0.38066, 0.47583, 0.2855))
    end
  end
end
