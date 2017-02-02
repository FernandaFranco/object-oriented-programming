# description: twenty-one is a game with a dealer and a player where the goal is
# to get closer to 21 with the sum of the values of the cards in your hand without
# busting. Every player starts with 2 cards. A player can hit until he makes 21
# or stay, giving the turn to the dealer. The dealer has to keep hitting until he
# makes 17. Whoever gets closer to 21 without busting is the winner.

# dealer
# player
# game
# deck
# card

# hit
# stay
# bust
# deal

module Hand
  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    @total = 0

    cards.each do |card|
      @total += card.value.to_i
      puts card.value.to_i
    end

    @total
  end
end

class Participant
  include Hand

  attr_accessor :cards, :total

  def initialize
  end
end

class Player < Participant
  def initialize
  end

end

class Dealer < Participant
end

class Card
  SUITS = %w(hearts diamonds clubs spades)
  VALUES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace)

  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    set_deck
  end

  def set_deck
    value_suit_pairs = Card::VALUES.product(Card::SUITS)
    value_suit_pairs.each do |pair|
      @cards << Card.new(*pair)
    end
  end
end

class Game
  attr_reader :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new

  end

  def deal_cards
    player.cards = deck.cards.sample(2)
    deck.cards.delete(player.cards[0])
    deck.cards.delete(player.cards[1])
    dealer.cards =  deck.cards.sample(2)
    deck.cards.delete(dealer.cards[0])
    deck.cards.delete(dealer.cards[1])
  end

  def show_initial_cards
    puts "Your cards are:"
    puts " - #{player.cards[0].value} of #{player.cards[0].suit}"
    puts " - #{player.cards[1].value} of #{player.cards[1].suit}"
    puts "You have a total of #{player.total}."
    puts ""
    puts "The dealer cards are:"
    puts " - #{dealer.cards[0].value} of #{dealer.cards[0].suit}"
    puts " - unknown"
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

Game.new.start