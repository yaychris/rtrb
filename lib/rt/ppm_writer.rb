class PPMWriter
  attr_reader :canvas

  def initialize(canvas)
    @canvas = canvas
  end

  def write
    [header_lines, data_lines].flatten.join("\n") + "\n"
  end

  def header_lines
    [identifier, dimensions, max_color]
  end

  def data_lines
    lines = []

    canvas.rows do |row|
      line = []

      row.each do |pixel|
        line << pixel.to_ppm
      end

      lines << line.flatten.join(' ')
    end

    wrap(lines, 70)
  end

  def wrap(data, max_length)
    lines = []

    data.each do |line|
      if line.length <= max_length
        lines << line
      else
        index = max_length - 1

        while line[index] != ' ' do
          index -= 1
        end

        lines << line.slice(0, index)
        lines << line.slice(index + 1, line.length - index)
      end
    end

    lines
  end

  def identifier
    'P3'
  end

  def dimensions
    "#{canvas.width} #{canvas.height}"
  end

  def max_color
    '255'
  end

end
