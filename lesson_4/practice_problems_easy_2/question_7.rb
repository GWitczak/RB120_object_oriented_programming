# Explain what the @@cats_count variable does and how it works. 
# What code would you need to write to test your theory?

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

# @@cats_count value is incremented by 1 each time we initialize new Cat object,
# we can use this class variable to check how many Cat class instances have been created

Cat.cats_count # => 0
Cat.new('Main Coon')
Cat.new('Persian')
p Cat.cats_count # => 2