class Stack

  def initialize
    @stack = []
  end

  def empty?
    @stack.empty?
  end

  def push(element)
    @stack.push(element)
  end

  def is_include?(elm)
    @stack.include?(elm)
  end

  def pop(elm=nil)
    return nil if empty?
    if elm.nil?
      @stack.pop
    else
      @stack.pop(elm)
    end
  end

  def top
    return nil if empty?
    @stack[@stack.length-1]
  end

  def last
    @stack.last()
  end

end




