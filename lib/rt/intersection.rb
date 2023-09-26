class Intersection
  attr_reader :t, :object, :point, :eye_v, :normal_v, :inside

  def initialize(t, object)
    @t = t
    @object = object
  end

  def negative?
    t.negative?
  end

  def inside?
    !!@inside
  end

  def ==(rh)
    @t == rh.t and @object == rh.object
  end

  def prepare(ray)
    @inside = false
    @point = ray.position(@t)
    @eye_v = -ray.direction
    @normal_v = @object.normal_at(@point)

    if @normal_v.dot(@eye_v) < 0
      @inside = true
      @normal_v = -@normal_v
    end
  end
end
