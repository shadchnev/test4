class Array
  def recursive_inject(*params, &block)
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

  def iterative_inject(*params, &block)
    if !block_given?
      # params is either [initial, op] or [op]
      operation = params.pop
      block = lambda {|acc, e| acc.send(operation, e)} 
    end
    # params is either [initial] or []
    initial = params.pop
    return initial if self.empty?
    accumulator =  initial.nil? ? self[0] : block.call(initial, self[0])
    self[1..-1].each do |element| 
      accumulator = block.call(accumulator, element)
    end
    accumulator
  end




end
