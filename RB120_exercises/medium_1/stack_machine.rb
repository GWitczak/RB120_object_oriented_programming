class Computer
  def initialize(numbers)
    @register = 0
    @stack = []
    @numbers = numbers
  end

  def empty_stack
    if @stack.empty?
      puts "Empty Stack!"
      return true
    else
      false
    end
  end

  def to_register
    @register = @numbers.shift
  end

  def push
    @stack << @register
  end

  def add
    @register += pop
  end

  def sub
    @register -= pop 
  end

  def mult
    @register *= pop 
  end

  def div
    @register /= pop 
  end

  def mod
    @register %= pop 
  end

  def pop
    @register = @stack.pop unless empty_stack
  end

  def print
    puts @register
  end
end

class Minilang
  def initialize(program)
    @program = program
    @tokens = transform(program)
    @numbers = find_numbers
    @computer = Computer.new(@numbers)
  end

  def transform(program)
    tokens = program.split.map do |token|
      if token.to_i.to_s == token
        :to_register
      else
        token.downcase
      end
    end
    tokens
  end

  def find_numbers
    @program.split.select { |number| number.to_i.to_s == number }.map(&:to_i)
  end

  def eval
    @tokens.each do |token| 
      begin
        @computer.send(token)
      rescue NoMethodError
        puts "Invalid token: #{token.upcase}"
        break
      end
    end
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)