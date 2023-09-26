class PointLight
  attr_accessor :position, :intensity

  def initialize(position, intensity)
    @position = position
    @intensity = intensity
  end
end
