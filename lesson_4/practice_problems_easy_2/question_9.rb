# What would happen if we added a play method to the Bingo class, keeping in mind that 
# there is already a method of this name in the Game class that the Bingo class inherits from.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# In that case if we will call play method on Bingo class object, Ruby will first search for this method
# in Bingo class and call method that we created there.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    'Play time!'
  end
end

bing = Bingo.new
bing.play # => 'Play time!'