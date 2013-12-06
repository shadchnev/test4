require 'test5'

describe Array do
  let(:array) {Array[1,2,3,4,5]}

  it 'should sum with a block' do
    expect(array.recursive_inject{|acc, e| acc += e}).to eq 15
    expect(array.iterative_inject{|acc, e| acc += e}).to eq 15
  end

  it 'should sum without a block' do
    expect(array.recursive_inject(:+)).to eq 15
    expect(array.iterative_inject(:+)).to eq 15
  end

  it 'should product' do
    expect(array.recursive_inject(:*)).to eq 120 
    expect(array.iterative_inject(:*)).to eq 120 
  end

  it 'should take an initial value' do
    expect(array.recursive_inject(-15){|acc, e| acc += e}).to eq 0
    expect(array.iterative_inject(-15){|acc, e| acc += e}).to eq 0
  end

  it 'should take both an initial value and an operation' do
    expect(array.recursive_inject(-15, :+)).to eq 0
    expect(array.iterative_inject(-15, :+)).to eq 0
  end
end

