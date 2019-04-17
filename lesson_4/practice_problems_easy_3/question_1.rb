class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1
hello = Hello.new
hello.hi # => 'Hello'

# case 2:
hello = Hello.new
hello.bye # => undefined method

# case 3:
hello = Hello.new
hello.greet # => Wrong Number Of Arguments expected 1 got 0

# case 4:
hello = Hello.new
hello.greet("Goodbye") # => 'Goodbye'

# case 5:
p Hello.hi # => undefined method