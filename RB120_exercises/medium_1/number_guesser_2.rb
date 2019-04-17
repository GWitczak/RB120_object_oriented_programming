class Player
  attr_accessor :number_of_guesses, :guess

  def initialize(range)
    @number_of_guesses = Math.log2(range.size).to_i + 1
    @guess = 0
  end
end

class GuessingGame
  attr_reader :number, :player, :min, :max, :range

  def initialize(min, max)
    @range = (min..max)
    @player = Player.new(range)
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
    @player = Player.new(range)
  end

  def initialize_number
    @number = rand(range)
  end

  def display_remaining_guesses
    puts "You have #{player.number_of_guesses} guesses remaining."
  end

  def player_guess
    answer = nil
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      answer = gets.chomp
      break if valid?(answer)
      print "Invalid guess. "
    end

    player.number_of_guesses -= 1
    player.guess = answer.to_i
  end

  def valid?(num)
    range.include?(num.to_i) && num.to_i.to_s == num
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
    if player.number_of_guesses == 0
      puts "You have no more guesses. You lost!"
      return true
    end
  end
end

game = GuessingGame.new(1, 25)
game.play

game.play

