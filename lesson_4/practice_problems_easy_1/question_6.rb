# What could we add to the class below to access the instance variable @volume?

class Cube
  attr_accessor :volume # this line will create getter and setter method for instance variable @volume
  def initialize(volume)
    @volume = volume
  end
end

sp = Cube.new(10)
p sp.volume # => 10
sp.volume = 15
p sp.volume # => 15