# width: 5
# height: 3
# 
# [
#   [x, x, x, x, x],
#   [x, x, x, x, x],
#   [x, x, x, x, x],
# ]
class Canvas
  attr_reader :width, :height

  def initialize(width, height, default_color: Color::BLACK)
    @width = width
    @height = height

    @data = Array.new(@height) do
      Array.new(width) { default_color }
    end
  end

  def [](x, y)
    @data[y][x]
  end

  def []=(x, y, color)
    @data[y][x] = color
  end

  def rows(&block)
    @data.each_with_index do |row, y|
      block.call(row, y)
    end
  end

  def each
    rows do |row, y|
      row.each_with_index do |color, x|
        yield x, y, color
      end
    end
  end
end
