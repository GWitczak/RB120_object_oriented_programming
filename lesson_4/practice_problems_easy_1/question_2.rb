# If we have a Car class and a Truck class and we want to be able to go_fast, 
# how can we add the ability for them to go_fast using the module Speed? 
# How can you check if your Car or Truck can now go fast?

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

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# We need to mixin module Speed to both classes. To check if Car/Truck can go_fast
# we neeed to instantinate object for this class and call .go_fast method on it.

ford = Car.new
ford.go_fast

chevy = Truck.new
chevy.go_fast

