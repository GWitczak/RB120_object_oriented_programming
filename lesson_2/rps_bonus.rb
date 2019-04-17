require 'pry'

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  WINNING_MOVES = {
    rock: %w(lizard scissors), paper: %w(rock spock),
    scissors: %w(paper lizard), lizard: %w(spock paper),
    spock: %w(scissors rock)
  }
  LOOSING_MOVES = {
    rock: %w(paper spock), paper: %w(scissors lizard),
    scissors: %w(rock spock), lizard: %w(rock scissors),
    spock: %w(lizard paper)
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_MOVES[@value.to_sym].include?(other_move.to_s)
  end

  def <(other_move)
    LOOSING_MOVES[@value.to_sym].include?(other_move.to_s)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :track

  def initialize
    @score = 0
    @track = []
  end

  def show_track
    puts "#{name}'s track of moves: #{track.join(', ')}"
  end
end

class Human < Player
  
  def initialize
    super
    set_name
  end

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
  def initialize
    @name = self.class.to_s
    super
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
    track << move
  end
end

class R2D2 < Computer
def choose
    self.move = 'rock'
    track << move
  end
end

class Hal < Computer
  def choose
    self.move = ['scissors', 'scissors', 'scissors', 'lizard'].sample
    track << move
  end
end

class Sonny < Computer
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [R2D2.new, Hal.new, Sonny.new].sample
  end

  def display_welcome_message
    puts "Welcome to RPS Bonus!"
    puts "Who will win 3 times first, is the winner!"
  end

  def display_goodbye_message
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
    if human.move > computer.move
      human.score += 1
    elsif human.move < computer.move
      computer.score += 1
    end
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
        human.show_track
        computer.show_track
        display_winner
        break unless play_again?
      end
    end
    display_goodbye_message
  end
end

RPSGame.new.play
