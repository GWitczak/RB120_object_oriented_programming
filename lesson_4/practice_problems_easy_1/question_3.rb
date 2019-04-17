# When we called the go_fast method from an instance of the Car class (as shown below) 
# you might have noticed that the string printed when we go fast includes the name of the type
# of vehicle we are using. How is this done?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

small_car = Car.new
small_car.go_fast # => "I am a Car and going super fast!"

# Thats because on line 7 within Speed module we use .class method on self 
# (self refers to the object itself, in this case either a Car or Truck object.) 
# to get the name of current class that go_fast method is called in. 