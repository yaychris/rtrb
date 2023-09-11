class Color
  attr_reader :r, :g, :b

  def initialize(r, g, b)
    @r = Float(r)
    @g = Float(g)
    @b = Float(b)
  end

  def ==(rh)
    @r == rh.r and @g == rh.g and @b == rh.b
  end

  def red
    @r
  end

  def green
    @g
  end

  def blue
    @b
  end

  def +(rh)
    Color.new(@r + rh.r, @g + rh.g, @b + rh.b)
  end

  def -(rh)
    Color.new(@r - rh.r, @g - rh.g, @b - rh.b)
  end

  def *(rh)
    case rh
    when Integer, Float
      s = Float(rh)

      Color.new(@r * s, @g * s, @b * s)

    when Color
      Color.new(@r * rh.r, @g * rh.g, @b * rh.b)

    else
      raise ArgumentError
    end
  end

  def to_a
    [@r, @g, @b]
  end

  def to_ppm
    to_a.map { |x| (x * 255).round.clamp(0, 255) }
  end
end

Color::BLACK = Color.new(0, 0, 0)
