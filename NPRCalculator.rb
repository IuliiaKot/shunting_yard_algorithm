require './stack'
require './shunting_yard_algorithm'

class NPRCalculator

  attr_accessor :polish_notation

  def initialize(string)
    @stack = Stack.new
    @reverse_polish_notation = ShuntingYardAlgorithm.new(string)
    #p @polish_notation
  end

  def plus
    raise 'calculator is empty' if @stack.empty?
    a, b = @stack.pop(2)
    @stack.push(a+b)
  end

  # @return [@stack]
  def minus
    raise 'calculator is empty' if @stack.empty?
    a, b = @stack.pop(2)
    @stack.push(-b+a)
  end

  def multiple
    raise 'calculator is empty' if @stack.empty?
    a, b = @stack.pop(2)
    @stack.push(a*b)
  end


  def divide
    raise 'calculator is empty' if @stack.empty?
    a, b = @stack.pop(2)
    @stack.push(a/b.to_f)

  end

  def power
    return nil if @stack.empty?
    a, b = @stack.pop(2)
    @stack.push(a**b)
  end

  def evaluate

    @reverse_polish_notation.output.each do |symbol|
      if symbol == '+'
        plus
      elsif symbol == '-'
        minus
      elsif symbol == '*'
        multiple
      elsif symbol == '/'
        divide
      elsif symbol == '^'
        power
      else
        @stack.push(eval(symbol))
      end
    end
    return @stack.last

  end

end
infix_expr = "1+12.4+(6+8)"
res = NPRCalculator.new(infix_expr)
puts "Reverse Polish notation #{res.reverse_polish_notation.output.join(" ")}"
res.reverse_polish_notation.error.nil? ? (puts "#{infix_expr}= #{res.evaluate}") : (puts res.reverse_polish_notation.error)