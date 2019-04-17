# If we have the class below, what would you need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# I would need to send 2 arguments to the .new method called on class name
# that will be assigned to intialize method parameters: color and material

Bag.new('blue','cotton')