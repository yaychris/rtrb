describe '#lighting' do
  let(:sqrt2) { Math.sqrt(2) }
  let(:material) { Material.new }
  let(:position) { Point(0, 0, 0) }

  context 'eye between the light and the surface' do
    let(:eye) { Vector(0, 0, -1) }
    let(:normal) { Vector(0, 0, -1) }
    let(:light) { PointLight.new(Point(0, 0, -10), Color.white) }

    it 'calculates the color at the position' do
      result = lighting(material, light, position, eye, normal)

      expect(result).to fixed_eq(Color.new(1.9, 1.9, 1.9))
    end
  end

  context 'eye between the light and the surface, eye offset 45 degrees' do
    let(:eye) { Vector(0, sqrt2 / 2, -sqrt2 / 2) }
    let(:normal) { Vector(0, 0, -1) }
    let(:light) { PointLight.new(Point(0, 0, -10), Color.white) }

    it 'calculates the color at the position' do
      result = lighting(material, light, position, eye, normal)

      expect(result).to fixed_eq(Color.new(1, 1, 1))
    end
  end

  context 'eye opposite surface, light offset 45 degrees' do
    let(:eye) { Vector(0, 0, -1) }
    let(:normal) { Vector(0, 0, -1) }
    let(:light) { PointLight.new(Point(0, 10, -10), Color.white) }

    it 'calculates the color at the position' do
      result = lighting(material, light, position, eye, normal)

      expect(result).to fixed_eq(Color.new(0.7364, 0.7364, 0.7364))
    end
  end

  context 'eye in the path of the reflection vector' do
    let(:eye) { Vector(0, -sqrt2 / 2, -sqrt2 / 2) }
    let(:normal) { Vector(0, 0, -1) }
    let(:light) { PointLight.new(Point(0, 10, -10), Color.white) }

    it 'calculates the color at the position' do
      result = lighting(material, light, position, eye, normal)

      expect(result).to fixed_eq(Color.new(1.6364, 1.6364, 1.6364))
    end
  end

  context 'light behind the surface' do
    let(:eye) { Vector(0, 0, -1) }
    let(:normal) { Vector(0, 0, -1) }
    let(:light) { PointLight.new(Point(0, 0, -0), Color.white) }

    it 'calculates the color at the position' do
      result = lighting(material, light, position, eye, normal)

      expect(result).to fixed_eq(Color.new(0.1, 0.1, 0.1))
    end
  end
end
