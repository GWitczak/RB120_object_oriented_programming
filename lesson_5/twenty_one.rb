module Cosmetics
  def empty_line
    puts ''
  end

  def dashed_line
    puts "------------------------------------"
  end

  def clear_screen
    system 'clear'
  end
end

class Participant
  attr_accessor :cards, :total, :action, :name
  include Cosmetics

  def initialize
    @cards = []
    @name = ''
    @total = total
  end

  def total
    card_values = cards.map(&:to_values)
    result = card_values.sum

    loop do
      break if result <= 21 || !card_values.include?(11)
      result -= 10
      card_values.sort!.pop
    end

    result
  end

  def busted?
    total > 21
  end

  def stay?
    action == 'stay'
  end

  def show_cards
    "#{cards.map(&:to_s)[0..-2].join(', ')} and #{cards.map(&:to_s)[-1]}"
  end

  def to_s
    "#{total} (#{show_cards})"
  end
end

class Player < Participant
  def set_name
    answer = ''
    puts "What's your name?"
    loop do
      answer = gets.chomp.capitalize
      break if !answer.empty?
      puts "You should type your name!"
    end
    self.name = answer
  end

  def hit(deck)
    dashed_line
    puts "You choose to hit!"
    cards << deck.deal_one
    puts "Your cards are now: #{show_cards}."
    puts "With total of #{total}."
    dashed_line
  end

  def stay
    dashed_line
    puts "You choose to stay! Dealer's turn..."
    dashed_line
    self.action = 'stay'
  end
end

class Dealer < Participant
  def set_name
    self.name = %w(R2D2 Smith BlackJoe Bunny CheatySam).sample
  end

  def show_card
    "#{cards.map(&:to_s).first} and unknown card"
  end

  def hit(deck)
    cards << deck.deal_one
    puts "#{name} choose to hit!"
    dashed_line
  end

  def stay
    puts "#{name} choose to stay!"
    dashed_line
    self.action = 'stay'
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end

    cards.shuffle!
  end

  def deal_one
    cards.pop
  end

  def deal(player, dealer)
    2.times do
      player.cards << deal_one
      dealer.cards << deal_one
    end
  end
end

class Card
  attr_reader :suit, :value

  SUITS = ['♣', '♦', '♥', '♠']
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_values
    if ['King', 'Queen', 'Jack'].include?(value)
      10
    elsif value == 'Ace'
      11
    else
      value
    end
  end

  def to_s
    "#{value}#{suit}"
  end
end

class TwentyOne
  attr_accessor :deck
  attr_reader :player, :dealer

  include Cosmetics

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    display_welcome_message
    set_names
    show_rules
    main_game_loop
    display_goodbye_message
  end

  private

  def main_game_loop
    loop do
      deal_cards
      show_initial_cards
      until player.busted? || player.stay?
        player_turn
      end
      player.busted? ? busted_message : dealer_turn
      show_result if all_stayed?
      break unless play_again?
      reset
    end
  end

  def play_again?
    answer = ''
    puts "Would you like to play again? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please choose 'y' or 'n'!"
    end

    answer == 'y'
  end

  def reset
    player.cards = []
    player.action = nil
    dealer.cards = []
    dealer.action = nil
    @deck = Deck.new
    clear_screen
  end

  def show_rules
    answer = ''
    empty_line
    puts "Hello #{player.name}! Would you like to read some rules? (y/n)"
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "You must choose 'y' or 'n'!"
    end
    rules if answer == 'y'
  end

  # rubocop:disable Metrics/MethodLength
  def rules
    puts "1) You start with a normal 52-card
    deck consisting of the 4 suits
    (hearts, diamonds, clubs, and spades),
    and 13 values (2, 3, 4, 5, 6, 7, 8,
    9, 10, jack, queen, king, ace)."
    gets
    puts "2) The goal of Twenty-One is to try
    to get as close to 21 as possible,
    without going over. If you go over 21,
    it's a 'bust' and you lose."
    gets
    puts "3) The game consists of a 'dealer' and
    a 'player'. Both participants are initially
    dealt 2 cards. The player can see their 2 cards,
    but can only see one of the dealer's cards."
    gets
    puts "4) All of the card values are pretty straightforward,
    except for the ace. The numbers 2through 10
    are worth their face value. The jack, queen,
    and king are each worth 10, and the ace can be
    worth 1 or 11. The ace's value is determined each time
    a new card is drawn from the deck. For example,
    if the hand contains a 2, an ace, and a 5, then
    the total value of the hand is 18. In this case,
    the ace is worth 11 because the sum of the hand
    (2 + 11 + 5) doesn't exceed 21."
    gets
    puts "5) Player turn: the player goes first,
    and can decide to either 'hit' or 'stay'.
    A hit means the player will ask for another card.
    Remember that if the total exceeds 21,
    then the player 'busts' and loses. "
    gets
    puts "6) Dealer turn: when the player stays, it's the
    dealer's turn. The dealer must follow a strict rule
    for determining whether to hit or stay: hit until
    the total is at least 17. If the dealer busts,
    then the player wins."
    gets
    puts "7) Comparing cards: when both the player and
    the dealer stay, it's time to compare the total
    value of the cards and see who has the highest value."
    puts ''
  end
  # rubocop:enable Metrics/MethodLength

  def set_names
    player.set_name
    dealer.set_name
  end

  def busted_message
    if player.busted?
      winner = dealer.name
      loser = player.name
    else
      winner = player.name
      loser = dealer.name
    end

    puts "#{loser} busted! #{winner} won!"
    dashed_line
  end

  def all_stayed?
    player.stay? && dealer.stay?
  end

  def show_result
    puts "#{player.name} total is: #{player}"
    puts "#{dealer.name} total is: #{dealer}"

    display_winner(player.total, dealer.total)
  end

  def display_winner(human, cpu)
    if human > cpu
      puts "#{player.name} won!"
    elsif human < cpu
      puts "#{dealer.name} won!"
    else
      puts "It's a tie!"
    end

    dashed_line
  end

  def player_turn
    answer = nil

    puts "Would you like to (h)it or (s)tay?"
    loop do
      answer = gets.chomp.downcase
      break if %w(h s).include?(answer)
      puts "You must choose between 'h' and 's'!"
    end

    answer == 's' ? player.stay : player.hit(deck)
  end

  def dealer_turn
    loop do
      dealer.total < 16 ? dealer.hit(deck) : break
    end

    dealer.busted? ? busted_message : dealer.stay
  end

  def deal_cards
    puts "---- Press Enter to deal cards! ----"
    gets
    deck.deal(player, dealer)
    clear_screen
  end

  def show_initial_cards
    dashed_line
    puts "#{player.name} has: #{player.show_cards}. Total of #{player.total}."
    puts "#{dealer.name} has: #{dealer.show_card}."
    dashed_line
  end

  def display_welcome_message
    clear_screen
    empty_line
    puts "------ Welcome to Twenty-One! ------"
    empty_line
  end

  def display_goodbye_message
    empty_line
    puts "- Thank you for playing Twenty-One! -"
    empty_line
    puts "               Goodbye!"
    empty_line
  end
end

game = TwentyOne.new
game.start
