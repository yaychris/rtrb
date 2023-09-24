class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def position(t)
    @origin + @direction * t
  end

  def transform(m)
    Ray.new(m * @origin, m * @direction)
  end
end
