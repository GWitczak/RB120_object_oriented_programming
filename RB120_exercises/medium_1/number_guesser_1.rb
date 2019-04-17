class Player
  attr_accessor :number_of_guesses, :guess

  def initialize
    @number_of_guesses = 7
    @guess = 0
  end
end

class GuessingGame
  attr_reader :number, :player

  def initialize
    @player = Player.new
  end

  def play
    initialize_number
    system 'clear'
    loop do
      display_remaining_guesses
      player_guess
      display_evaluation
      break if player_won? || player_out_of_guesses?
    end
    sleep(2)
    reset
  end

  private

  def reset
    player.number_of_guesses = 7
  end

  def initialize_number
    @number = rand(1..100)
  end

  def display_remaining_guesses
    puts "You have #{player.number_of_guesses} guesses remaining."
  end

  def player_guess
    answer = nil
    print "Enter a number between 1 and 100: "
    loop do
      answer = gets.chomp
      break if valid?(answer)
      print "Invalid guess. Enter a number between 1 and 100: "
    end

    player.number_of_guesses -= 1
    player.guess = answer.to_i
  end

  def valid?(num)
    (1..100).include?(num.to_i) && num.to_i.to_s == num
  end

  def display_evaluation
    if player.guess < number
      puts "Your guess is to low." 
      puts ''
    elsif player.guess > number
      puts "Your guess is to high." 
      puts ''
    end
  end

  def player_won?
    if player.guess == number
      puts "That's the number!"
      puts ''
      puts "You won!"
      return true
    end
    false
  end

  def player_out_of_guesses?
    if player.number_of_guesses <= 0
      puts "You have no more guesses. You lost!"
      return true
    end
  end
end


game = GuessingGame.new
game.play
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!