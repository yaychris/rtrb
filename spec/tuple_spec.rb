require 'tuple'

describe Tuple do
  describe '#new' do
    subject { Tuple.new(4.3, -4.2, 3.1, 1.0) }

    it 'returns a new tuple' do
      expect(subject.x).to equal(4.3)
      expect(subject.y).to equal(-4.2)
      expect(subject.z).to equal(3.1)
      expect(subject.w).to equal(1.0)

      expect(subject.point?).to be(true)
      expect(subject.vector?).to be(false)
    end
  end

  describe 'addition' do
    let(:a) { Tuple.new(3, -2, 5, 1) }
    let(:b) { Tuple.new(-2, 3, 1, 0) }

    it 'adds and returns a new tuple' do
      result = Tuple.new(1, 1, 6, 1)

      expect(a + b).to eq(result)
    end
  end

  describe 'subtraction' do
    context 'two points' do
      let(:a) { Point(3, 2, 1) }
      let(:b) { Point(5, 6, 7) }

      it 'returns a vector' do
        result = Vector(-2, -4, -6)

        expect(a - b).to eq(result)
      end
    end

    context 'vector from a point' do
      let(:a) { Point(3, 2, 1) }
      let(:b) { Vector(5, 6, 7) }

      it 'returns a point' do
        result = Point(-2, -4, -6)

        expect(a - b).to eq(result)
      end
    end

    context 'two vectors' do
      let(:a) { Vector(3, 2, 1) }
      let(:b) { Vector(5, 6, 7) }

      it 'returns a vector' do
        result = Vector(-2, -4, -6)

        expect(a - b).to eq(result)
      end
    end

    context 'vector from zero vector' do
      let(:zero) { Vector(0, 0, 0) }

      subject { Vector(1, -2, 3) }

      it 'returns the negated vector' do
        result = Vector(-1, 2, -3)

        expect(zero - subject).to eq(result)
      end
    end
  end

  describe 'negation' do
    subject { Tuple.new(1, -2, 3, -4) }

    it 'negates the tuple' do
      result = Tuple.new(-1, 2, -3, 4)

      expect(-subject).to eq(result)
    end
  end

  describe "scalar multiplication" do
    context 'scalar' do
      subject { Tuple.new(1, -2, 3, -4) }

      it 'returns a scaled tuple' do
        expect(subject * 3.5).to eq(Tuple.new(3.5, -7, 10.5, -14))
      end
    end

    context 'fraction' do
      subject { Tuple.new(1, -2, 3, -4) }

      it 'returns a scaled tuple' do
        expect(subject * 0.5).to eq(Tuple.new(0.5, -1, 1.5, -2))
      end
    end
  end

  describe 'scalar division' do
    subject { Tuple.new(1, -2, 3, -4) }

    it 'returns a scaled tuple' do
      expect(subject / 2).to eq(Tuple.new(0.5, -1, 1.5, -2))
    end
  end

  describe '#magnitude' do
    cases = [
      [Vector(1, 0, 0), 1],
      [Vector(0, 1, 0), 1],
      [Vector(0, 0, 1), 1],
      [Vector(1, 2, 3), Math.sqrt(14)],
      [Vector(-1, -2, -3), Math.sqrt(14)],
    ]

    it 'computes the magnitude' do
      cases.each do |(subject, expected)|
        expect(subject.magnitude).to eq(expected)
      end
    end
  end

  describe '#normalize' do
    cases = [
      [Vector(4, 0, 0), Vector(1, 0, 0)],
      [Vector(1, 2, 3), Vector(1/Math.sqrt(14), 2/Math.sqrt(14), 3/Math.sqrt(14))],
    ]

    it 'normalizes the vector to unit vector' do
      cases.each do |(subject, expected)|
        result = subject.normalize

        expect(result).to eq(expected)
        expect(result.magnitude).to eq(1)
      end
    end
  end

  describe '#dot' do
    let(:a) { Vector(1, 2, 3) }
    let(:b) { Vector(2, 3, 4) }

    it 'returns the dot product' do
      expect(a.dot(b)).to eq(20)
    end
  end

  describe '#cross' do
    let(:a) { Vector(1, 2, 3) }
    let(:b) { Vector(2, 3, 4) }

    it 'returns the cross product' do
      expect(a.cross(b)).to eq(Vector(-1, 2, -1))
      expect(b.cross(a)).to eq(Vector(1, -2, 1))
    end
  end
end

describe 'Point' do
  subject { Point(4, -4, 3) }

  it 'returns a point' do
    expect(subject).to eq(Tuple.new(4, -4, 3, 1.0))
  end
end

describe 'Vector' do
  subject { Vector(4, -4, 3) }

  it 'returns a vector' do
    expect(subject).to eq(Tuple.new(4, -4, 3, 0.0))
  end
end
