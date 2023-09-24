describe '#dot' do
  let(:a) { [1, 2, 3] }
  let(:b) { [2, 3, 4] }

  it 'returns the dot product' do
    expect(dot(a, b)).to eq(20)
  end
end

describe '#is_even?' do
  it 'returns the correct answer' do
    expect(is_even?(2)).to be(true)
    expect(is_even?(3)).to be(false)
  end
end

describe '#is_odd?' do
  it 'returns the correct answer' do
    expect(is_odd?(1)).to be(true)
    expect(is_odd?(2)).to be(false)
  end
end
