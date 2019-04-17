
class Greeting
  def greet(message)
    puts message
  end
end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

class Hello
  def self.hi 
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

Hello.hi