class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# On line 20 we initialize local variable name and assign integer 42 to it.
# Then we pass name as an argument to new method called on Pet class
# Inside Pet class when new object is instantiated 42 is converted to string object and assigned to instance variable name
# That why calling puts on object of Class pet or on return value of name method called on Pet object output 42 as name
# On line 27 we invoke puts method with local variable name passed in as argument since on line 22 we incremented it by 1
# puts method outputs 43.

name = 42
fluffy = Pet.new(name)
name += 1

puts fluffy.name
puts fluffy
puts fluffy.name
puts name