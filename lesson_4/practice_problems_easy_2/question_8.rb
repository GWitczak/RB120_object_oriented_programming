# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

class Game
  def play
    "Start the game!"
  end
end


class Bingo < Game # we need to mkae Bingo a subclass of Game, by '< Game' we are telling Ruby that class Bingo will inherit from the Game class
  def rules_of_play
    #rules of play
  end
end

bing = Bingo.new
p bing.play