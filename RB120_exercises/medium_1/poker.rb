require 'pry'

class Card
  attr_reader :rank, :suit

  include Comparable

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other_card)
    evaluate(rank) <=> evaluate(other_card.rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def evaluate(value)
    case value
    when 'Jack' then 11
    when 'Queen' then 12
    when 'King' then 13
    when 'Ace' then 14
    else value
    end
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  attr_reader :cards

  def initialize
    @cards = []
    reset
  end

  def draw
    reset if cards.empty?
    cards.pop
  end

  private

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
end

class PokerHand
  include Comparable
  attr_reader :hand

  SCORES = {'Royal flush' => 10, 'Straight flush' => 9, 'Four of a kind' => 8,
            'Full house' => 7, 'Flush' => 6, 'Straight' => 5, 'Three of a kind' => 4,
            'Two pair' => 3, 'Pair' => 2, 'High card' => 1}

  def initialize(deck)
    @deck = deck
    @hand = []
    5.times { @hand << @deck.draw }
  end

  def print
    puts @hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

#further exploration 
  def self.royal_flush?(cards_in_hand)
    sorted = cards_in_hand.map {|card| card.evaluate(card.rank)}.sort
    self.flush?(cards_in_hand) && sorted == (sorted.first..14).to_a
  end

  def self.flush?(cards_in_hand)
    flush = cards_in_hand.map { |card| card.suit }
    flush.uniq.size == 1
  end

  def <=>(other_hand)
    SCORES[evaluate] <=> SCORES[other_hand.evaluate]
  end

  def best_five_of_seven
    return @hand if @hand.size != 7
    @hand = @hand.combination(5).to_a.map { |ele| PokerHand.new(ele) }.max.hand
  end

  def add_two_cards
    @hand << @deck.draw
    @hand << @deck.draw
  end

  private

  def hand_ranks
    @hand.map {|card| card.rank}
  end

  def hand_suits
    @hand.map {|card| card.suit}
  end

  def royal_flush?
    sorted = @hand.map {|card| card.evaluate(card.rank)}.sort
    flush? && sorted == (sorted.first..14).to_a
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    @hand.each do |card|
      return true if hand_ranks.count(card.rank) == 4
    end
    false
  end

  def full_house?
    ranks = hand_ranks.uniq
    return true if hand_ranks.count(ranks.first) + hand_ranks.count(ranks.last) == 5
    false
  end

  def flush?
    flush = @hand.map { |card| card.suit }
    flush.uniq.size == 1
  end

  def straight?
    sorted = @hand.map {|card| card.evaluate(card.rank)}.sort
    sorted == (sorted.first..sorted.last).to_a
  end

  def three_of_a_kind?
    @hand.each do |card|
      return true if hand_ranks.count(card.rank) == 3
    end
    false
  end

  def two_pair?

    two_pair = hand_ranks.uniq.map do |rank|
      hand_ranks.count(rank)
    end

    two_pair.count(2) >= 2
  end

  def pair?
    @hand.each do |card|
      return true if hand_ranks.count(card.rank) == 2
    end
    false
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

puts ''
puts "Test to choose best 5 cards poker hand from 7 cards"
hand = PokerHand.new(Deck.new)
hand.add_two_cards # Adding 2 cards to five card poker hand
puts '---------------------'
hand.print
puts hand.evaluate 
puts '---------------------'
puts hand.best_five_of_seven # returns new value of our hand with best possible option
puts hand.evaluate
puts ''
puts "End of test"
puts ''


puts "Test for class method .royal_flush?"
puts ''
puts PokerHand.royal_flush?([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts ''
puts "End of test for class method"
puts ''


puts "Test that we can identify each PokerHand type."
puts ''
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])

puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'