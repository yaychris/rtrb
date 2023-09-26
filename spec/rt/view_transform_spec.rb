describe '#view_transform' do
  subject { view_transform(from, to, up) }

  context 'default orientation' do
    let(:from) { Point(0, 0, 0) }
    let(:to) { Point(0, 0, -1) }
    let(:up) { Vector(0, 1, 0) }

    it 'returns the identity matrix' do
      expect(subject).to eq(Matrix.identity)
    end
  end

  context 'looking in the positive z direction' do
    let(:from) { Point(0, 0, 0) }
    let(:to) { Point(0, 0, 1) }
    let(:up) { Vector(0, 1, 0) }

    it 'returns the correct matrix' do
      expect(subject).to eq(Matrix.scaling(-1, 1, -1))
    end
  end

  context 'moves the world' do
    let(:from) { Point(0, 0, 8) }
    let(:to) { Point(0, 0, 0) }
    let(:up) { Vector(0, 1, 0) }

    it 'returns the correct matrix' do
      expect(subject).to eq(Matrix.translation(0, 0, -8))
    end
  end

  context 'arbitrary view transformation' do
    let(:from) { Point(1, 3, 2) }
    let(:to) { Point(4, -2, 8) }
    let(:up) { Vector(1, 1, 0) }

    it 'returns the correct matrix' do
      expect(subject).to fixed_eq(Matrix.new([
        [-0.50709, 0.50709,  0.67612, -2.36643],
        [ 0.76772, 0.60609,  0.12122, -2.82843],
        [-0.35857, 0.59761, -0.71714,  0.00000],
        [ 0.00000, 0.00000,  0.00000,  1.00000],
      ]))
    end
  end
end
