class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new # => creates new object of the Television class
tv.manufacturer # => undefined method name, its class method, not instance method
tv.model # => call model method on tv object as receiver

Television.manufacturer # => call class method manufacturer on the class Television
Television.model # => undefined method name it's a instance method, can't be used on class directly