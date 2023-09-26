class World
  attr_accessor :objects, :light

  def self.default
    world = World.new

    sphere1 = Sphere.new
    sphere1.material.color = Color.new(0.8, 1.0, 0.6)
    sphere1.material.diffuse = 0.7
    sphere1.material.specular = 0.2

    sphere2 = Sphere.new
    sphere2.transform = Matrix.scaling(0.5, 0.5, 0.5)

    world.objects = [sphere1, sphere2]
    world.light = PointLight.new(Point(-10, 10, -10), Color.white)

    world
  end

  def initialize(objects = [], light = nil)
    @objects = objects
    @light = light
  end

  def intersect(ray)
    xs = objects.map { |o| o.intersect(ray) }.flatten

    IntersectionList.new(xs)
  end

  def shade(intersection)
    lighting(
      intersection.object.material,
      light,
      intersection.point,
      intersection.eye_v,
      intersection.normal_v
    )
  end

  def color_at(ray)
    xs = intersect(ray)
    hit = xs.hit

    return Color.black unless hit

    hit.prepare(ray)
    shade(hit)
  end
end
