# In the name of the cats_count method we have used self. What does self refer to in this context?

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# In this case, self refers to the class Cat - methods with self. in the method name are class methods 
# and can be used directly on class name: Cat.cats_count