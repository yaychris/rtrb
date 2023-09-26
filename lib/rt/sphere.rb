class Sphere
  attr_reader :origin, :radius

  attr_accessor :transform, :material

  def initialize
    @origin = Point(0, 0, 0)
    @radius = 1.0
    @transform = Matrix.identity
    @material = Material.new
  end

  def ==(rh)
    @origin == rh.origin and
      @radius == rh.radius and
      @transform == rh.transform and
      @material == rh.material
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

  def normal_at(p)
    inverse = transform.inverse

    local_point = inverse * p
    local_normal = local_point - Point(0, 0, 0)

    normal = inverse.transpose * local_normal

    normal.w = 0.0
    normal.normalize
  end
end
