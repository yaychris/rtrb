describe IntersectionList do
  describe '#new' do
    let(:sphere) { Sphere.new }
    let(:i1) { Intersection.new(1, sphere) }
    let(:i2) { Intersection.new(2, sphere) }

    subject { IntersectionList.new([i1, i2]) }

    it 'returns a list of intersections' do
      expect(subject.count).to eq(2)
      expect(subject[0]).to eq(i1)
      expect(subject[1]).to eq(i2)
    end
  end

  describe '#hit' do
    let(:sphere) { Sphere.new }

    subject { IntersectionList.new([i1, i2]) }

    context 'all intersections have positive t' do
      let(:i1) { Intersection.new(1, sphere) }
      let(:i2) { Intersection.new(2, sphere) }

      it 'returns the first intersection' do
        expect(subject.hit).to eq(i1)
      end
    end

    context 'some intersections have negative t' do
      let(:i1) { Intersection.new(-1, sphere) }
      let(:i2) { Intersection.new(1, sphere) }

      it 'returns the first positive intersection' do
        expect(subject.hit).to eq(i2)
      end
    end

    context 'all intersections have negative t' do
      let(:i1) { Intersection.new(-2, sphere) }
      let(:i2) { Intersection.new(-1, sphere) }

      it 'returns nothing' do
        expect(subject.hit).to be_nil
      end
    end

    context 'lots of nonnegative intersections' do
      let(:i1) { Intersection.new(5, sphere) }
      let(:i2) { Intersection.new(7, sphere) }
      let(:i3) { Intersection.new(-3, sphere) }
      let(:i4) { Intersection.new(2, sphere) }

      subject { IntersectionList.new([i1, i2, i3, i4]) }

      it 'the lowest nonnegative intersection' do
        expect(subject.hit).to eq(i4)
      end
    end
  end
end
