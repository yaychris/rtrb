class Sphere
  attr_reader :origin, :radius

  attr_accessor :transform

  def initialize
    @origin = Point(0, 0, 0)
    @radius = 1.0
    @transform = Matrix.identity
  end

  def intersect(ray)
    result = IntersectionList.new

    r2 = ray.transform(@transform.inverse)

    self_to_r2 = r2.origin - @origin

    a = r2.direction.dot(r2.direction)
    b = 2 * r2.direction.dot(self_to_r2)
    c = self_to_r2.dot(self_to_r2) - 1

    discriminant = b*b - 4*a*c

    return result if discriminant < 0

    two_a = 2*a
    sqrt_d = Math.sqrt(discriminant)

    t1 = (-b - sqrt_d) / two_a
    t2 = (-b + sqrt_d) / two_a

    result << Intersection.new(t1, self)
    result << Intersection.new(t2, self)
  end
end
