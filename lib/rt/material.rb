class Material
  attr_accessor :color, :ambient, :diffuse, :specular, :shininess

  def initialize
    @color = Color.new(1, 1, 1)
    @ambient = 0.1
    @diffuse = 0.9
    @specular = 0.9
    @shininess = 200.0
  end
end
