require './stack'


class ShuntingYardAlgorithm

  attr_accessor :output, :error

  def initialize(expression)
    @output = []
    @stack = Stack.new
    return (@error = 'The input string is empty') if expression.length == 0
    expression = expression.split('')
    process(expression)
  end


  def process(expression)

    expression.each_with_index do |symbol, index|
      if is_number?(symbol)
        if (index != 0)
          if is_number?(expression[index-1]) || expression[index-1] == '.'
            @output.push(@output.pop + symbol)
          else
            @output.push(symbol)
          end
        else
          @output.push(symbol)
        end
      elsif symbol == '.'
        @output.push(@output.pop + symbol)

      elsif is_operator?(symbol)
        next if index == 0 || expression[index-1] == '('

        if @stack.empty?
          @stack.push(symbol)
        else
          while !@stack.empty?
            if precedence(symbol) <= precedence(@stack.top)
              @output.push(@stack.pop)
            else
              break
            end
          end
          @stack.push(symbol)
        end

      elsif symbol == '('
        @stack.push(symbol)
      elsif symbol == ')'
        while @stack.top != '('
          @output.push(@stack.pop)
        end
        @stack.pop
      end
    end

    print_npr

  end


  def print_npr
    if @stack.is_include?('(')
      return (@error = 'The input string contains unbalanced parentheses')
    end
    while !@stack.empty?
      @output.push(@stack.pop)
    end
    return @output
  end

  private

    def is_number?(token)
      !!(token =~ /\d+/)
    end

    def is_operator?(token)
      return true if '%w + - * / ^'.include?(token)
    end

    def precedence(token)
      if token == '+' || token == '-'
        return 2
      elsif token == '/' || token == '*'
        return 3
      elsif token == '^'
        return 5
      else
        return 0
      end
    end

end


