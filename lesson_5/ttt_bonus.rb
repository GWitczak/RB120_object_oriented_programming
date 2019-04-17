require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]
  attr_reader :squares

  def initialize
    @squares = {} # {1 => Square.new(' '), 2 => Square.new(' ')}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won_round?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      marker = @squares.values_at(*line).map(&:marker).uniq
      return marker[0] if marker.size == 1 && marker[0] != ' '
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :marker, :name

  def initialize
    @score = 0
    @marker = nil
    @name = ''
  end

  def to_s
    "#{name} marker: '#{marker}'. Score: #{score}"
  end

  def won?
    score == TTTGame::MAX_SCORE
  end

  def opposite_marker
    case marker
    when 'X' then 'O'
    when 'O' then 'X'
    end
  end
end

class TTTGame
  attr_reader :board, :human, :computer
  attr_accessor :current_player
  MAX_SCORE = 3

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
  end

  def play
    clear
    display_welcome_message
    set_options
    main_game_loop
    display_goodbye_message
  end

  private

  def main_game_loop
    loop do
      play_round
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def play_round
    loop do
      clear_screen_and_display_board
      loop do
        current_player_moves
        break if board.someone_won_round? || board.full?
        clear_screen_and_display_board
      end
      increment_winner_score
      display_who_scored
      gets
      break if human.won? || computer.won?
      board.reset
      clear_screen_and_display_board
    end
  end

  def set_options
    set_names
    set_markers
    set_who_starts_first
  end

  def set_markers
    answer = nil
    puts "Choose your marker: 'X' or 'O'"
    loop do
      answer = gets.chomp.upcase
      break if ['X', 'O'].include?(answer)
      puts "Wrong choice. Enter 'X' or 'O'!"
    end
    human.marker = answer
    computer.marker = human.opposite_marker
    puts ''
  end

  def set_names
    human_name = ''
    puts "What's your name?"
    loop do
      human_name = gets.chomp.capitalize
      break if !human_name.empty?
    end
    human.name = human_name
    computer.name = %w(R2D2 Elf3000 Smith Droid007).sample
    puts "Hey #{human.name}! You will play with #{computer.name}!"
    puts ''
  end

  def display_who_scored
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker     then puts "#{human.name} won and get a point!"
    when computer.marker  then puts "#{computer.name} won and gets a point!"
    else                       puts "It's a tie!"
    end
  end

  def increment_winner_score
    case board.winning_marker
    when human.marker then human.score += 1
    when computer.marker then computer.score += 1
    end
  end

  def joinor(arr, delimiter=', ', conj='or')
    return arr[0] if arr.size == 1
    "#{arr[0..-2].join(delimiter)} #{conj} #{arr[-1]}"
  end

  def set_who_starts_first
    answer = nil
    h = human.name
    c = computer.name
    puts "Who should start the game? #{h} or #{c}?"
    loop do
      answer = gets.chomp.downcase
      break if [h.downcase, c.downcase].include?(answer)
      puts "You must enter '#{h}' or '#{c}'"
    end

    if answer == h.downcase
      self.current_player = human
    else
      self.current_player = computer
    end
  end

  def display_welcome_message
    puts "---------- Welcome to Tic Tac Toe! ----------"
    puts ''
    puts "             Press Enter to start"
    gets
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts human
    puts computer
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Chose a square: #{joinor(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def possibility_of_win?
    !risk_line(computer.marker).empty?
  end

  def possibility_of_lose?
    !risk_line(human.marker).empty?
  end

  def computer_moves
    if possibility_of_win?
      offensive_move
    elsif possibility_of_lose?
      defensive_move
    elsif board.squares[5].unmarked?
      board[5] = computer.marker
    else
      random_move
    end
  end

  def offensive_move
    risk_line(computer.marker).each do |num|
      board[num] = computer.marker if board.squares[num].unmarked?
    end
  end

  def random_move
    board[board.unmarked_keys.sample] = computer.marker
  end

  def defensive_move
    risk_line(human.marker).each do |num|
      board[num] = computer.marker if board.squares[num].unmarked?
    end
  end

  def risk_line(marker)
    # return winning line if 2 of squares in winning line are marked by argument
    # and third is an initial marker
    Board::WINNING_LINES.each do |line|
      arr = line.map do |square|
        board.squares[square].marker
      end
      return line if arr.sort == [Square::INITIAL_MARKER, marker, marker]
    end
    []
  end

  def current_player_moves
    if current_player == human
      human_moves
      self.current_player = computer
    else
      computer_moves
      self.current_player = human
    end
  end

  def display_result
    clear_screen_and_display_board
    puts "#{winner} won! #{human.score} : #{computer.score}"
  end

  def winner
    human.score == MAX_SCORE ? human.name : computer.name
  end

  def play_again?
    answer = nil
    loop do
      puts ''
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def reset
    board.reset
    human.score = 0
    computer.score = 0
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ''
  end
end

game = TTTGame.new
game.play
