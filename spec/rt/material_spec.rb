describe Material do
  describe '#new' do
    subject { Material.new }

    it 'returns a default material' do
      expect(subject.color).to eq(Color.new(1, 1, 1))
      expect(subject.ambient).to eq(0.1)
      expect(subject.diffuse).to eq(0.9)
      expect(subject.specular).to eq(0.9)
      expect(subject.shininess).to eq(200.0)
    end
  end
end
