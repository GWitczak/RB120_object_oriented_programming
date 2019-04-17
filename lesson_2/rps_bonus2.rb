require 'pry'

module ToS
  def to_s
    self.class.to_s.downcase
  end
end

class Move
  attr_accessor :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    case value
    when 'paper'    then @value = Paper.new
    when 'rock'     then @value = Rock.new
    when 'scissors' then @value = Scissors.new
    when 'spock'    then @value = Spock.new
    when 'lizard'   then @value = Lizard.new
    end
  end

  def to_s
    @value
  end
end

class Rock
  include ToS
  def >(other_move)
    ['lizard', 'scissors'].include?(other_move.to_s)
  end

  def <(other_move)
    ['paper', 'spock'].include?(other_move.to_s)
  end
end

class Paper
  include ToS
  def >(other_move)
    ['rock', 'spock'].include?(other_move.to_s)
  end

  def <(other_move)
    ['lizard', 'scissors'].include?(other_move.to_s)
  end
end

class Lizard
  include ToS
  def >(other_move)
    ['paper', 'spock'].include?(other_move.to_s)
  end

  def <(other_move)
    ['scissors', 'rock'].include?(other_move.to_s)
  end
end

class Scissors
  include ToS
  def >(other_move)
    ['paper', 'lizard'].include?(other_move.to_s)
  end

  def <(other_move)
    ['rock', 'spock'].include?(other_move.to_s)
  end
end

class Spock
  include ToS
  def >(other_move)
    ['rock', 'scissors'].include?(other_move.to_s)
  end

  def <(other_move)
    ['paper', 'lizard'].include?(other_move.to_s)
  end
end

class Player
  attr_accessor :name, :score, :track
  attr_writer :move

  def initialize
    set_name
    @score = 0
    @track = []
  end

  def move
    @move.value
  end

  def show_track
    puts "#{name}'s history of moves: #{track.join(', ')}."
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "Whats your name?"
      n = gets.chomp
      break unless n.empty?
    end
    self.name = n.capitalize
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    track << move
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 7'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    track << move
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPS Bonus!"
    puts "Who will win 3 times first, is the winner!"
  end

  def display_goodbye_message
    human.show_track
    computer.show_track
    puts "Thanks for playing RPS Bonus. Good Bye!"
  end

  def display_winner
    h = human.score
    c = computer.score
    puts h > c ? "#{human.name} won!" : "#{computer.name} won!"
  end

  def display_moves_and_score
    h = human.name
    c = computer.name
    puts "#{h} choose #{human.move}."
    puts "#{c} choose #{computer.move}."
    puts "#{h}: #{human.score}"
    puts "#{c}: #{computer.score}"
  end

  def calculate_score!
    human.score += 1 if human.move > computer.move
    computer.score += 1 if human.move < computer.move
  end

  def reset_score!
    human.score = 0
    computer.score = 0
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n"
    end
    if answer == 'y'
      reset_score!
      return true
    end
    false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      calculate_score!
      display_moves_and_score
      if human.score == 3 || computer.score == 3
        display_winner
        break unless play_again?
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play
