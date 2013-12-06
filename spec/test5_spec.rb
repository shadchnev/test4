require 'test5'

describe 'Enumerable.my_inject' do
  it 'should sum' do
    [1,2,3,4].my_inject(:+).should == 10
  end

  it 'should do the same thing as the previous it block' do
    [1,2,3,4,5].my_inject(:+).should == 15
  end

  it 'should not sum' do
    [1,2,3,4,5].my_inject(:+).should_not == 10
  end

  it 'should product' do
    [1,2,3,4].my_inject(:*).should == 24 
  end

  it 'should '
end
