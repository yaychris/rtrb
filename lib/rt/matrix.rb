class Matrix
  attr_reader :data

  def self.zero
    Matrix.new([
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
    ])
  end

  def self.identity
    Matrix.new([
      [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
    ])
  end

  def self.translation(x, y, z)
    Matrix.new([
      [1, 0, 0, x],
      [0, 1, 0, y],
      [0, 0, 1, z],
      [0, 0, 0, 1],
    ])
  end

  def self.scaling(x, y, z)
    Matrix.new([
      [x, 0, 0, 0],
      [0, y, 0, 0],
      [0, 0, z, 0],
      [0, 0, 0, 1],
    ])
  end

  def self.rotation_x(rad)
    Matrix.new([
      [1, 0,             0,              0],
      [0, Math.cos(rad), -Math.sin(rad), 0],
      [0, Math.sin(rad), Math.cos(rad),  0],
      [0, 0,             0,              1],
    ])
  end

  def self.rotation_y(rad)
    Matrix.new([
      [Math.cos(rad),  0, Math.sin(rad), 0],
      [0,              1, 0,             0],
      [-Math.sin(rad), 0, Math.cos(rad), 0],
      [0,              0, 0,             1],
    ])
  end

  def self.rotation_z(rad)
    Matrix.new([
      [Math.cos(rad), -Math.sin(rad), 0, 0],
      [Math.sin(rad), Math.cos(rad),  0, 0],
      [0,             0,              1, 0],
      [0,             0,              0, 1],
    ])
  end

  def self.shearing(xy, xz, yx, yz, zx, zy)
    Matrix.new([
      [1,  xy, xz, 0],
      [yx, 1,  yz, 0],
      [zx, zy, 1,  0],
      [0,  0,  0,  1],
    ])
  end

  def self.from_tuple(t)
    new([
      [t.x],
      [t.y],
      [t.z],
      [t.w],
    ])
  end

  def initialize(data)
    @data = data.map(&:dup).map do |x|
      x.map { |v| Float(v) }
    end
  end

  def [](row, col)
    data[row][col]
  end

  def []=(row, col, val)
    self.data[row][col] = val
  end

  def ==(rh)
    data == rh.data
  end

  def num_rows
    data.length
  end

  def num_cols
    data.fetch(0, []).length
  end

  def row(n)
    data.fetch(n, [])
  end

  def col(n)
    data.map { |row| row[n] }
  end

  def each
    data.each_with_index do |row, row_index|
      row.each_with_index do |val, col_index|
        yield val, row_index, col_index
      end
    end
  end

  def each_row(&block)
    data.each_with_index(&block)
  end

  def each_col(&block)
    result = []

    0.upto(num_cols - 1) do |i|
      result << col(i)
    end

    result.each_with_index(&block)
  end

  def *(rh)
    is_tuple = rh.is_a?(Tuple)

    rh = self.class.from_tuple(rh) if is_tuple

    result = []

    each_row do |row|
      new_row = []

      rh.each_col do |col|
        new_row << dot(row, col)
      end

      result << new_row
    end

    if is_tuple
      Tuple.new(*result.flatten)
    else
      Matrix.new(result)
    end
  end

  def transpose
    result = []

    each_col { |c| result << c }

    Matrix.new(result)
  end

  def determinant
    if num_rows == 2
      return self[0, 0]*self[1, 1] - self[0, 1]*self[1,0]
    end

    data[0].each_with_index.reduce(0) do |sum, (val, col_index)|
      sum + val * cofactor(0, col_index)
    end
  end

  def submatrix(del_row, del_col)
    result = each_row.reduce([]) do |m, (row, row_index)|
      if row_index != del_row
        m << row.each_with_index.select do |(_, col_index)|
          col_index != del_col
        end.map(&:first)
      end

      m
    end

    return Matrix.new(result)
  end

  def minor(row, col)
    submatrix(row, col).determinant
  end

  def cofactor(row, col)
    multiplier = is_odd?(row + col) ? -1 : 1

    return multiplier * minor(row, col)
  end

  def is_invertible?
    determinant != 0
  end

  def inverse
    det = determinant

    result = Matrix.new(data)

    0.upto(num_rows - 1) do |row|
      0.upto(num_cols - 1) do |col|
        cf = cofactor(row, col)

        result[col, row] = cf / det
      end
    end

    result
  end

  def to_fixed
    Matrix.new(
      data.map do |row|
        row.map(&:to_fixed)
      end
    )
  end
end
