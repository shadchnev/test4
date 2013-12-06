require 'test5'

describe Array do
  let(:array) {MyArray[1,2,3,4,5]}

  it 'should sum with a block' do
    expect(array.my_inject{|acc, e| acc += e}).to eq 15
  end

  it 'should sum without a block' do
    expect(array.my_inject(:+)).to eq 15
  end

  it 'should product' do
    expect(array.my_inject(:*)).to eq 120 
  end

  it 'should take an initial value' do
    expect(array.my_inject(-15){|acc, e| acc += e}).to eq 0
  end

  it 'should take both an initial value and an operation' do
    expect(array.my_inject(-15, :+)).to eq 0
  end
end

