class Vehicle

  attr_accessor :color, :speed, :year, :model

  @@number_of_vehicles = 0

  def self.amount
    @@number_of_vehicles
  end

  def speed_up(km)
    self.speed += km
    "Whoa! You are speeding up! #{km} km/h!"
  end

  def brake(km)
    self.speed -= km
    "You slowed down to #{speed} km/h!"
  end

  def shut_off
    self.speed = 0
    'Vehicle is shutted off.'
  end

  def spray_paint(col)
    self.color = col
    "You've painted your vehicle. Now it is #{col}!"
  end

  def self.gas_mileage(l, km)
    puts "Average fuel consumption for 100km is #{((100 * l).to_f / km).round(2)}l"
  end

  def initialize(year, color, model)
    self.year = year
    self.color = color
    self.model = model.capitalize
    self.speed = 0
    @@number_of_vehicles += 1
  end

  def age
    "Your #{model} is #{calculate_years} years old!"
  end

  private
  def calculate_years
    Time.now.year - year
  end
end

module Towable
  def can_tow?(pounds)
    pounds > 2000 ? false : true
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Towable

  def to_s
    "My truck is a #{self.color}, #{self.year}, #{self.model}!"
  end
end

# p Vehicle.amount
ford = MyCar.new(2002, 'blue', 'ford')
chev = MyCar.new(2008, 'green', 'chev')
merc = MyTruck.new(2015, 'red', 'Mercedes')
chevy = MyCar.new(2002, 'red', 'chevrolet')
# p Vehicle.amount
# p merc.can_tow?(3500)

# puts "---Vehicle method lookup---"
# puts Vehicle.ancestors

# puts "---MyCar method lookup---"
# puts MyCar.ancestors

# puts "---MyTruck method lookup---"
# puts MyTruck.ancestors

# MyCar.gas_mileage(87, 1130)

# puts chevy
# p chevy.spray_paint('blue')
# p chevy.speed_up(60)
# p chevy.brake(40)
# p chevy.shut_off

p merc.age
p ford.age






