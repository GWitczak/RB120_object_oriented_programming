# What is the default return value of to_s when invoked on an object? 
# Where could you go to find out if you want to be sure?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

big = Cube.new(2000)

# Default return value of to_s is information about object class and an encoding of the object id
# I could search for answer on Ruby documentation in Object#to_s method

puts big # => #<Cube:0x00007fbc1d0e8db0>