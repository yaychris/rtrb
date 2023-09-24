describe Intersection do
  describe '#new' do
    let(:sphere) { Sphere.new }

    subject { Intersection.new(3.5, sphere) }

    it 'returns the intersection' do
      expect(subject.t).to eq(3.5)
      expect(subject.object).to eq(sphere)
    end
  end
end
