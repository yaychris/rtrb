class Matrix
  extend MatrixTransforms

  attr_reader :data

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

    0.upto(num_rows - 1) do |row|
      new_row = []

      0.upto(rh.num_cols - 1) do |col|
        new_row <<
          self[row, 0] * rh[0, col] +
          self[row, 1] * rh[1, col] +
          self[row, 2] * rh[2, col] +
          self[row, 3] * rh[3, col]
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
    return @determinant if instance_variable_defined?(:@determinant)

    @determinant = if num_rows == 2
      self[0, 0]*self[1, 1] - self[0, 1]*self[1,0]
    else
      data[0].each_with_index.reduce(0) do |sum, (val, col_index)|
        sum + val * cofactor(0, col_index)
      end
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
    return @inverse if instance_variable_defined?(:@inverse)
    det = determinant

    result = Matrix.new(data)

    0.upto(num_rows - 1) do |row|
      0.upto(num_cols - 1) do |col|
        cf = cofactor(row, col)

        result[col, row] = cf / det
      end
    end

    @inverse = result
  end

  def to_fixed
    Matrix.new(
      data.map do |row|
        row.map(&:to_fixed)
      end
    )
  end
end
