describe PointLight do
  describe '#new' do
    let(:position) { Point(0, 0, 0) }
    let(:intensity) { Color.white }

    subject { PointLight.new(position, intensity) }

    it 'returns a new light' do
      expect(subject.position).to eq(Point(0, 0, 0))
      expect(subject.intensity).to eq(Color.white)
    end
  end
end
