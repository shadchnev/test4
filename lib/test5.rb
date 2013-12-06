class Array
  def my_inject(*params, &block)
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

  def my_iterative_inject(operation)
    result = self[0]
    self[1..-1].each do |element| 
      result = result.send(operation, element)
    end
    result
  end
end
