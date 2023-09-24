describe Matrix do
  describe '#new' do
    describe '2x2' do
      subject do
        Matrix.new([
          [-3, 5],
          [1,  -2],
        ])
      end

      it 'initializes the matrix' do
        expect(subject[0, 0]).to eq(-3)
        expect(subject[0, 1]).to eq(5)
        expect(subject[1, 0]).to eq(1)
        expect(subject[1, 1]).to eq(-2)
      end
    end

    describe '3x3' do
      subject do
        Matrix.new([
          [-3, 5,  0],
          [1,  -2, -7],
          [0,  1,  1],
        ])
      end

      it 'initializes the matrix' do
        expect(subject[0, 0]).to eq(-3)
        expect(subject[1, 1]).to eq(-2)
        expect(subject[2, 2]).to eq(1)
      end
    end

    describe '4x4' do
      subject do
        Matrix.new([
          [1,    2,    3,    4],
          [5.5,  6.5,  7.5,  8.5],
          [9,    10,   11,   12],
          [13.5, 14.5, 15.5, 16.5],
        ])
      end

      it 'initializes the matrix' do
        expect(subject[0, 0]).to eq(1)
        expect(subject[0, 3]).to eq(4)
        expect(subject[1, 0]).to eq(5.5)
        expect(subject[1, 2]).to eq(7.5)
        expect(subject[2, 2]).to eq(11)
        expect(subject[3, 0]).to eq(13.5)
        expect(subject[3, 2]).to eq(15.5)
      end
    end
  end

  describe '#==' do
    describe 'equality' do
      let(:a) do
        Matrix.new([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2],
        ])
      end

      let(:b) do
        Matrix.new([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2],
        ])
      end

      it 'returns true' do
        expect(a == b).to be(true)
      end
    end

    describe 'inequality' do
      let(:a) do
        Matrix.new([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2],
        ])
      end

      let(:b) do
        Matrix.new([
          [2, 3, 4, 5],
          [6, 7, 8, 9],
          [8, 7, 6, 5],
          [4, 3, 2, 1],
        ])
      end

      it 'returns true' do
        expect(a == b).to be(false)
      end
    end
  end

  describe 'row & col introspection' do
    let(:empty) { Matrix.new([]) }

    subject do
      Matrix.new([
        [1, 2, 3],
        [4, 5, 6],
      ])
    end

    describe '#num_rows' do
      context 'empty matrix' do
        it 'returns 0' do
          expect(empty.num_rows).to eq(0)
        end
      end

      context 'matrix with data' do
        it 'returns row count' do
          expect(subject.num_rows).to eq(2)
        end
      end
    end

    describe '#num_cols' do
      context 'empty matrix' do
        it 'returns 0' do
          expect(empty.num_cols).to eq(0)
        end
      end

      context 'matrix with data' do
        it 'returns column count' do
          expect(subject.num_cols).to eq(3)
        end
      end
    end

    describe '#row' do
      context 'empty matrix' do
        it 'returns empty array' do
          expect(empty.row(0)).to eq([])
        end
      end

      context 'matrix with data' do
        it 'returns row' do
          expect(subject.row(0)).to eq([1, 2, 3])
          expect(subject.row(1)).to eq([4, 5, 6])
        end
      end
    end

    describe '.col()' do
      context 'empty matrix' do
        it 'returns empty array' do
          expect(empty.col(0)).to eq([])
        end
      end

      context 'matrix with data' do
        it 'returns column' do
          expect(subject.col(0)).to eq([1, 4])
          expect(subject.col(1)).to eq([2, 5])
          expect(subject.col(2)).to eq([3, 6])
        end
      end
    end
  end

  describe 'multiplication' do
    context 'two matrices' do
      let(:a) do
        Matrix.new([
          [1, 2, 3, 4],
          [5, 6, 7, 8],
          [9, 8, 7, 6],
          [5, 4, 3, 2],
        ])
      end

      let(:b) do
        Matrix.new([
          [-2, 1, 2, 3],
          [3,  2, 1, -1],
          [4,  3, 6, 5],
          [1,  2, 7, 8],
        ])
      end

      it 'returns the correct matrix' do
        expect(a * b).to eq(Matrix.new([
          [20, 22, 50, 48],
          [44, 54, 114, 108],
          [40, 58, 110, 102],
          [16, 26, 46, 42],
        ]))
      end
    end

    context 'matrix and 1x4 matrix' do
      let(:a) do
        Matrix.new([
          [1, 2, 3, 4],
          [2, 4, 4, 2],
          [8, 6, 4, 1],
          [0, 0, 0, 1],
        ])
      end

      let(:b) do
        Matrix.new([
          [1],
          [2],
          [3],
          [1],
        ])
      end

      it 'returns the correct matrix' do
        expect(a * b).to eq(Matrix.new([
          [18],
          [24],
          [33],
          [1],
        ]))
      end
    end

    context 'matrix and identity matrix' do
      subject do
        Matrix.new([
          [1, 2, 3, 4],
          [2, 4, 4, 2],
          [8, 6, 4, 1],
          [0, 0, 0, 1],
        ])
      end

      it 'returns the correct matrix' do
        expect(subject * Matrix.identity).to eq(subject)
      end
    end

    context 'matrix and tuple' do
      subject do
        Matrix.new([
          [1, 2, 3, 4],
          [2, 4, 4, 2],
          [8, 6, 4, 1],
          [0, 0, 0, 1],
        ])
      end

      let(:tuple) { Tuple.new(1, 2, 3, 1) }

      it 'returns the correct tuple' do
        result = Tuple.new(18, 24, 33, 1)

        expect(subject * tuple).to eq(result)
      end
    end
  end


  describe '#transpose' do
    describe 'non-identity matrix' do
      subject do
        Matrix.new([
          [0, 9, 3, 0],
          [9, 8, 0, 8],
          [1, 8, 5, 3],
          [0, 0, 5, 8],
        ])
      end

      let(:result) do
        Matrix.new([
          [0, 9, 1, 0],
          [9, 8, 8, 0],
          [3, 0, 5, 5],
          [0, 8, 3, 8],
        ])
      end

      it 'returns the transposed matrix' do
        expect(subject.transpose()).to eq(result)
      end
    end

    describe 'identity matrix' do
      it 'returns the identity' do
        expect(Matrix.identity.transpose()).to eq(Matrix.identity)
      end
    end
  end

  describe '#determinant' do
    describe '2x2 matrix' do
      subject do
        Matrix.new([
          [1,  5],
          [-3, 2],
        ])
      end

      it 'returns the determinant' do
        expect(subject.determinant).to eq(17)
      end
    end

    describe '3x3 matrix' do
      subject do
        Matrix.new([
          [1,  2, 6],
          [-5, 8, -4],
          [2,  6, 4],
        ])
      end

      it 'returns the determinant' do
        expect(subject.cofactor(0, 0)).to eq(56)
        expect(subject.cofactor(0, 1)).to eq(12)
        expect(subject.cofactor(0, 2)).to eq(-46)
        expect(subject.determinant()).to eq(-196)
      end
    end

    describe '4x4 matrix' do
      subject do
        Matrix.new([
          [-2, -8, 3,  5],
          [-3, 1,  7,  3],
          [1,  2,  -9, 6],
          [-6, 7,  7,  -9],
        ])
      end

      it 'returns the determinant' do
        expect(subject.cofactor(0, 0)).to eq(690)
        expect(subject.cofactor(0, 1)).to eq(447)
        expect(subject.cofactor(0, 2)).to eq(210)
        expect(subject.cofactor(0, 3)).to eq(51)
        expect(subject.determinant()).to eq(-4071)
      end
    end
  end

  describe '#submatrix' do
    describe '3x3' do
      subject do
        Matrix.new([
          [1,  5, 0],
          [-3, 2, 7],
          [0,  6, -3],
        ])
      end

      let(:result) do
        Matrix.new([
          [-3, 2],
          [0,  6],
        ])
      end

      it 'returns the correct 3x3 matrix' do
        expect(subject.submatrix(0, 2)).to eq(result)
      end
    end

    describe '4x4' do
      subject do
        Matrix.new([
          [-6, 1, 1, 6],
          [-8, 5, 8, 6],
          [-1, 0, 8, 2],
          [-7, 1, -1, 1],
        ])
      end

      let(:result) do
        Matrix.new([
          [-6, 1,  6],
          [-8, 8,  6],
          [-7, -1, 1],
        ])
      end

      it 'returns the correct 2x2 matrix' do
        expect(subject.submatrix(2, 1)).to eq(result)
      end
    end
  end


  describe '#minor' do
    subject do
      Matrix.new([
        [3, 5,  0],
        [2, -1, -7],
        [6, -1, 5],
      ])
    end

    let(:submatrix) do
      Matrix.new([
        [5,  0],
        [-1, 5],
      ])
    end

    it 'returns the minor' do
      expect(subject.submatrix(1, 0)).to eq(submatrix)
      expect(submatrix.determinant).to eq(25)
      expect(subject.minor(1, 0)).to eq(25)
    end
  end

  describe '#cofactor' do
    subject do
      Matrix.new([
        [3, 5,  0],
        [2, -1, -7],
        [6, -1, 5],
      ])
    end

    it 'returns the cofactor' do
      expect(subject.minor(0, 0)).to eq(-12)
      expect(subject.cofactor(0, 0)).to eq(-12)
      expect(subject.minor(1, 0)).to eq(25)
      expect(subject.cofactor(1, 0)).to eq(-25)
    end
  end

  describe '#is_invertible?' do
    describe 'is invertible' do
      subject do
        Matrix.new([
          [6, 4,  4, 4],
          [5, 5,  7, 6],
          [4, -9, 3, -7],
          [9, 1,  7, -6],
        ])
      end

      it 'returns true' do
        expect(subject.is_invertible?).to be(true)
      end
    end

    describe 'is not invertible' do
      subject do
        Matrix.new([
          [-4, 2,  -2, -3],
          [9,  6,  2,  6],
          [0,  -5, 1,  -5],
          [0,  0,  0,  0],
        ])
      end

      it 'returns false' do
        expect(subject.is_invertible?).to be(false)
      end
    end
  end

  describe '#inverse' do
    describe 'test case 1' do
      subject do
        Matrix.new([
          [-5, 2,  6,  -8],
          [1,  -5, 1,  8],
          [7,  7,  -6, -7],
          [1,  -3, 7,  4],
        ])
      end

      let(:result) do
        Matrix.new([
          [0.21805,  0.45113,  0.24060,  -0.04511],
          [-0.80827, -1.45677, -0.44361, 0.52068],
          [-0.07895, -0.22368, -0.05263, 0.19737],
          [-0.52256, -0.81391, -0.30075, 0.30639],
        ])
      end

      it 'returns the inverse' do
        inverse = subject.inverse

        expect(subject.determinant).to eq(532)

        expect(subject.cofactor(2, 3)).to eq(-160)
        expect(inverse[3, 2]).to fixed_eq(result[3, 2])

        expect(subject.cofactor(3, 2)).to eq(105)
        expect(inverse[2, 3]).to fixed_eq(result[2, 3])

        expect(inverse).to fixed_eq(result)
      end
    end

    describe 'test case 2' do
      subject do
        Matrix.new([
          [8, -5, 9, 2],
          [7, 5, 6, 1],
          [-6, 0, 9, 6],
          [-3, 0, -9, -4],
        ])
      end

      let(:result) do
        Matrix.new([
          [-0.15385, -0.15385, -0.28205, -0.53846],
          [-0.07692, 0.12308,  0.02564,  0.03077],
          [0.35897,  0.35897,  0.43590,  0.92308],
          [-0.69231, -0.69231, -0.76923, -1.92308],
        ])
      end

      it 'returns the inverse' do
        inverse = subject.inverse

        expect(inverse).to fixed_eq(result)
      end
    end

    describe 'test case 3' do
      subject do
        Matrix.new([
          [9, 3, 0, 9],
          [-5, -2, -6, -3],
          [-4, 9, 6, 4],
          [-7, 6, 6, 2],
        ])
      end

      let(:result) do
        Matrix.new([
          [-0.04074, -0.07778, 0.14444,  -0.22222],
          [-0.07778, 0.03333,  0.36667,  -0.33333],
          [-0.02901, -0.14630, -0.10926, 0.12963],
          [0.17778,  0.06667,  -0.26667, 0.33333],
        ])
      end

      it 'returns the inverse' do
        inverse = subject.inverse

        expect(inverse).to fixed_eq(result)
      end
    end

    describe 'multiplying a product by its inverse' do
      let(:a) do
        Matrix.new([
          [3,  -9, 7,  3],
          [3,  -8, 2,  -9],
          [-4, 4,  4,  1],
          [-6, 5,  -1, 1],
        ])
      end

      let(:b) do
        Matrix.new([
          [8, 2,  2, 2],
          [3, -1, 7, 0],
          [7, 0,  5, 4],
          [6, -2, 0, 5],
        ])
      end

      it 'returns the original matrix' do
        c = a * b

        subject = c * b.inverse

        subject.each do |val, row, col|
          expect(val).to fixed_eq(a[row, col])
        end
      end
    end
  end

  describe 'translation' do
    describe 'Matrix.translation' do
      subject do
        Matrix.translation(5, -3, 2)
      end

      it 'returns a translation matrix' do
        expect(subject).to eq(Matrix.new([
          [1, 0, 0, 5],
          [0, 1, 0, -3],
          [0, 0, 1, 2],
          [0, 0, 0, 1],
        ]))
      end
    end

    describe 'multiplying point by translation matrix' do
      let(:m) { Matrix.translation(5, -3, 2) }
      let(:p) { Point(-3, 4, 5) }

      it 'moves the point' do
        expect(m * p).to eq(Point(2, 1, 7))
      end
    end

    describe 'multiplying point by inverse of translation matrix' do
      let(:m) { Matrix.translation(5, -3, 2) }
      let(:p) { Point(-3, 4, 5) }

      it 'moves in the opposite direction' do
        expect(m.inverse * p).to eq(Point(-8, 7, 3))
      end
    end

    describe 'multiplying vector by translation matrix' do
      let(:m) { Matrix.translation(5, -3, 2) }
      let(:v) { Vector(-3, 4, 5) }

      it 'does not change the vector' do
        expect(m * v).to eq(v)
      end
    end
  end

  describe 'scaling' do
    describe 'Matrix.scaling' do
      subject { Matrix.scaling(2, 3, 4) }

      it 'returns a scale matrix' do
        expect(subject).to eq(Matrix.new([
          [2, 0, 0, 0],
          [0, 3, 0, 0],
          [0, 0, 4, 0],
          [0, 0, 0, 1],
        ]))
      end
    end

    describe 'multiplying point by scaling matrix' do
      let(:m) { Matrix.scaling(2, 3, 4) }
      let(:p) { Point(-4, 6, 8) }

      it 'scales the point' do
        expect(m * p).to eq(Point(-8, 18, 32))
      end
    end

    describe 'multiplying vector by scaling matrix' do
      let(:m) { Matrix.scaling(2, 3, 4) }
      let(:v) { Vector(-4, 6, 8) }

      it 'scales the vector' do
        expect(m * v).to eq(Vector(-8, 18, 32))
      end
    end

    describe 'multiplying vector by inverse scaling matrix' do
      let(:m) { Matrix.scaling(2, 3, 4) }
      let(:v) { Vector(-4, 6, 8) }

      it 'scales the vector' do
        expect(m.inverse * v).to eq(Vector(-2, 2, 2))
      end
    end

    describe 'multiplying by a reflection matrix' do
      let(:m) { Matrix.scaling(-1, 1, 1) }
      let(:p) { Point(2, 3, 4) }

      it 'reflects the point' do
        expect(m * p).to eq(Point(-2, 3, 4))
      end
    end
  end

  describe 'rotating' do
    let(:sqrt2) { Math.sqrt(2) }

    describe 'rotating point around x' do
      let(:half_quarter) { Matrix.rotation_x(Math::PI/4) }
      let(:quarter) { Matrix.rotation_x(Math::PI/2) }
      let(:p) { Point(0, 1, 0) }

      it 'rotates correctly' do
        result = half_quarter * p
        expect(result).to fixed_eq(Point(0, sqrt2/2, sqrt2/2))

        result = quarter * p
        expect(result).to fixed_eq(Point(0, 0, 1))
      end

      it 'inverse matrix rotates the other way' do
        result = half_quarter.inverse * p

        expect(result).to fixed_eq(Point(0, sqrt2/2, -sqrt2/2))
      end
    end

    describe 'rotating point around y' do
      let(:half_quarter) { Matrix.rotation_y(Math::PI/4) }
      let(:quarter) { Matrix.rotation_y(Math::PI/2) }
      let(:p) { Point(0, 0, 1) }

      it 'rotates correctly' do
        result = half_quarter * p
        expect(result).to fixed_eq(Point(sqrt2/2, 0, sqrt2/2))

        result = quarter * p
        expect(result).to fixed_eq(Point(1, 0, 0))
      end
    end

    describe 'rotating point around z' do
      let(:half_quarter) { Matrix.rotation_z(Math::PI/4) }
      let(:quarter) { Matrix.rotation_z(Math::PI/2) }
      let(:p) { Point(0, 1, 0) }

      it 'rotates correctly' do
        result = half_quarter * p
        expect(result).to fixed_eq(Point(-sqrt2/2, sqrt2/2, 0))

        result = quarter * p
        expect(result).to fixed_eq(Point(-1, 0, 0))
      end
    end
  end

  describe 'shearing' do
    let(:p) { Point(2, 3, 4) }

    describe 'moving x in proportion to y' do
      let(:m) { Matrix.shearing(1, 0, 0, 0, 0, 0) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(5, 3, 4))
      end
    end

    describe 'moving x in proportion to z' do
      let(:m) { Matrix.shearing(0, 1, 0, 0, 0, 0) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(6, 3, 4))
      end
    end

    describe 'moving y in proportion to x' do
      let(:m) { Matrix.shearing(0, 0, 1, 0, 0, 0) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(2, 5, 4))
      end
    end

    describe 'moving y in proportion to z' do
      let(:m) { Matrix.shearing(0, 0, 0, 1, 0, 0) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(2, 7, 4))
      end
    end

    describe 'moving z in proportion to x' do
      let(:m) { Matrix.shearing(0, 0, 0, 0, 1, 0) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(2, 3, 6))
      end
    end

    describe 'moving z in proportion to y' do
      let(:m) { Matrix.shearing(0, 0, 0, 0, 0, 1) }

      it 'moves the point' do
        expect(m * (p)).to eq(Point(2, 3, 7))
      end
    end
  end

  describe 'chaining transformations' do
    let(:p) { Point(1, 0, 1) }
    let(:a) { Matrix.rotation_x(Math::PI/2) }
    let(:b) { Matrix.scaling(5, 5, 5) }
    let(:c) { Matrix.translation(10, 5, 7) }

    describe 'individual transformations' do
      it 'transforms correctly' do
        p2 = a * p
        expect(p2).to fixed_eq(Point(1, -1, 0))

        p3 = b * p2
        expect(p3).to fixed_eq(Point(5, -5, 0))

        p4 = c * p3
        expect(p4).to fixed_eq(Point(15, 0, 7))
      end
    end

    describe 'chained function calls' do
      it 'transforms correctly' do
        t = c * b * a

        expect(t * p).to eq(Point(15, 0, 7))
      end
    end
  end
end
