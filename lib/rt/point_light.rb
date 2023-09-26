class PointLight
  attr_accessor :position, :intensity

  def initialize(position, intensity)
    @position = position
    @intensity = intensity
  end

  def ==(rh)
    @position == rh.position and @intensity == rh.intensity
  end
end
