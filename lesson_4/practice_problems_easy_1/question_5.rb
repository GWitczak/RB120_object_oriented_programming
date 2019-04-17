# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Class Pizza has instance variable @name. 

# Instance variable start with @, so in Fruit class we are not initializing 
# instance variable, instead we are reassigning local variable name to the same object
