class Camera
  DISTANCE_TO_CANVAS = 1.0

  attr_accessor :hsize, :vsize, :fov, :transform

  attr_reader :pixel_size, :half_width, :half_height

  def initialize(hsize, vsize, fov)
    @hsize = hsize.to_f
    @vsize = vsize.to_f
    @fov = fov
    @transform = Matrix.identity

    calculate_pixel_size
  end

  def hsize=(w)
    @hsize = w.to_f
    calculate_pixel_size
  end

  def vsize=(h)
    @vsize = h.to_f
    calculate_pixel_size
  end

  def fov=(f)
    @fov = f
    calculate_pixel_size
  end

  def ray_for_pixel(x, y)
    x_offset = (x + 0.5) * @pixel_size
    y_offset = (y + 0.5) * @pixel_size

    world_x = @half_width - x_offset
    world_y = @half_height - y_offset

    pixel = @transform.inverse * Point(world_x, world_y, -DISTANCE_TO_CANVAS)
    origin = @transform.inverse * Point(0, 0, 0)
    direction = (pixel - origin).normalize

    Ray.new(origin, direction)
  end

  def each_pixel
    0.upto(@vsize - 1) do |y|
      0.upto(@hsize - 1) do |x|
        yield x, y
      end
    end
  end

  def render(world)
    canvas = Canvas.new(@hsize, @vsize)

    each_pixel do |x, y|
      ray = ray_for_pixel(x, y)
      color = world.color_at(ray)

      canvas[x, y] = color
    end

    canvas
  end

  private

  def calculate_pixel_size
    half_view = Math.tan(@fov / 2)
    aspect_ratio = @hsize / @vsize

    if aspect_ratio >= 1
      @half_width = half_view
      @half_height = half_view / aspect_ratio
    else
      @half_width = half_view * aspect_ratio
      @half_height = half_view
    end

    @pixel_size = (@half_width * 2) / @hsize
  end
end
