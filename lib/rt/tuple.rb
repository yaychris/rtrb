class Tuple
  attr_accessor :x, :y, :z, :w

  def initialize(x, y, z, w)
    @x = Float(x)
    @y = Float(y)
    @z = Float(z)
    @w = Float(w)
  end

  def point?
    @w == 1.0
  end

  def vector?
    @w == 0.0
  end

  def ==(rh)
    @x == rh.x and @y == rh.y and @z == rh.z and @w == rh.w
  end

  def +(rh)
    Tuple.new(@x + rh.x, @y + rh.y, @z + rh.z, @w + rh.w)
  end

  def -(rh)
    Tuple.new(@x - rh.x, @y - rh.y, @z - rh.z, @w - rh.w)
  end

  def -@
    Tuple.new(-@x, -@y, -@z, -@w)
  end

  def *(s)
    s = Float(s)

    Tuple.new(@x * s, @y * s, @z * s, @w * s)
  end

  def /(s)
    s = Float(s)

    Tuple.new(@x / s, @y / s, @z / s, @w / s)
  end

  def magnitude
    Math.sqrt(@x**2 + @y**2 + @z**2 + @w**2)
  end

  def normalize
    length = magnitude

    Tuple.new(@x / length, @y / length, @z / length, @w / length)
  end

  def dot(rh)
    (@x * rh.x) + (@y * rh.y) + (@z * rh.z) + (@w * rh.w)
  end

  def cross(rh)
    Vector(
      @y * rh.z - @z * rh.y,
      @z * rh.x - @x * rh.z,
      @x * rh.y - @y * rh.x
    )
  end

  def to_fixed
    Tuple.new(x.to_fixed, y.to_fixed, z.to_fixed, w.to_fixed)
  end

  def inspect
    "#<Tuple (#{[@x, @y, @z, @w].join(", ")})>"
  end

  def reflect(normal)
    self - normal * 2 * self.dot(normal)
  end
end

def Point(x, y, z)
  Tuple.new(x, y, z, 1.0)
end

def Vector(x, y, z)
  Tuple.new(x, y, z, 0.0)
end
