require 'map'


describe MyArray do
  let(:array) {MyArray[1,2,3,4,5]}

  context 'map' do
    it 'should take a block mapping an array of integers to their double' do
      expect(array.map{|e| e * 2 }).to eq [2,4,6,8,10]
    end

    it 'should take a blockified parameter' do
      expect(array.map(&:even?)).to eq [false, true, false, true, false]
    end

    it 'should take a proc' do
      pro = Proc.new {|e| e * 2}
      expect(array.map(&pro)).to eq [2,4,6,8,10]
    end
  end

  context 'map2' do
    it 'should take a block mapping an array of integers to their double' do
      expect(array.recursive_map{|e| e * 2 }).to eq [2,4,6,8,10]
    end
  end

  context 'select' do
    it 'should take a block selecting even numbers' do
      expect(array.select{|e| e.odd?}).to eq [1,3,5]
    end

    it 'should take a blockified parameter' do
      expect(array.select(&:even?)).to eq [2,4]
    end
  end

  context 'each' do
    it 'should take a block and yield at each element' do
      expect{|block| array.each(&block)}.to yield_successive_args(1,2,3,4,5)
      # acc = []
      # array.each{|e| acc << e}
      # expect(acc).to eq [1,2,3,4,5]
    end
  end

  context 'inject' do
    it 'should sum with a block' do
      expect(array.inject{|acc, e| acc += e}).to eq 15
    end

    it 'should sum without a block' do
      expect(array.inject(:+)).to eq 15
    end

    it 'should product' do
      expect(array.inject(:*)).to eq 120 
    end

    it 'should take an initial value' do
      expect(array.inject(-15){|acc, e| acc += e}).to eq 0
    end

    it 'should take both an initial value and an operation' do
      expect(array.inject(-15, :+)).to eq 0
    end
  end
end


describe Array do
  context 'recursive sum' do
    it 'should sum an empty array' do
      expect([].sum).to eq 0
    end

    it 'should sum an array with one element' do
      expect([3].sum).to eq 3
    end

    it 'should sum a long array' do
      expect([1,2,3,4,5].sum).to eq 15
    end
  end

  context 'palindrome' do
    it 'should return true for an empty array' do
      expect([]).to be_palindrome
    end

    it 'should return true for a singlet array' do
      expect([1]).to be_palindrome
    end

    it 'should return true for an even-length palindrome' do
      expect([1,2,2,1]).to be_palindrome
    end

    it 'should return true for an odd-length palindrome' do
      expect([1,2,3,2,1]).to be_palindrome
    end

    it 'should return false for a non-palindrome' do
      expect([1,2,3,4,5]).to_not be_palindrome
    end
  end






















end
class MyArray < Array
  def map
    self.inject([]) do |acc, e|
      acc << yield(e)
    end
  end

  def recursive_map(&block)
    self.empty? ? [] : [yield(self[0])] + self[1..-1].recursive_map(&block)
  end

  def select
    self.inject([]) do |acc, e|
      yield(e) ? acc << e : acc
    end  
  end

  def each
    self.length.times do |i|
      yield(self[i])
    end
  end

  def inject(*params, &block)
    if !block_given?
      # params is either [initial, op] or [op]
      operation = params.pop
      block = lambda {|acc, e| acc.send(operation, e)} 
    end
    # params is either [initial] or []
    initial = params.pop
    return initial if self.empty?
    new_initial =  initial.nil? ? self[0] : block.call(initial, self[0])
    self[1..-1].inject(new_initial, &block) 
  end
end

class Array
  # methods which don't clash with builtin array

  def sum
    # recursive (non-inject-using) implementation
    self.empty? ? 0 : self[0] + self[1..-1].sum
  end

  def palindrome?
    return true if self.length <= 1
    self[first] == self[last] && self[1..-2].palindrome?
  end
end




module Enumerable
  def my_inject(operation)
    result = self[0]
    self[1..-1].each do |element| 
      result = result.send(operation, element)
    end
    result
  end
end
