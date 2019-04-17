#  Which one of these is a class method (if any) and how do you know? How would you call a class method?

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# self.manufacturer is a class method, because it has prefix self. that means i can call it directly on class
# just like that: Television.manufacturer