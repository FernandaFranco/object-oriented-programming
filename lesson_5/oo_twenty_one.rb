# description: twenty-one is a game with a dealer and a player where the goal is
# to get closer to 21 with the sum of the values of the cards in your hand
# without busting. Both with 2 cards. A player can hit until he makes 21 or
# stay, yielding the turn to the dealer. The dealer has to keep hitting until he
# makes 17 or surpass it. Whoever gets closer to 21 without busting is the
# winner.

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
    puts "#{name} chose to hit."
    puts "#{name}'s cards are:"
    cards.each do |card|
      puts " - #{card.value} of #{card.suit}"
    end
    puts "#{name} has a total of #{total}."
    puts "#{name} busted!" if busted?
  end

  def stay
    puts "#{name} chose to stay at #{total}."
  end

  def busted?
    total > 21
  end

  def total
    @total = 0
    aces = 0
    cards.each do |card|
      @total += card.actual_value
      aces += 1 if card.value == "ace"
    end

    aces.times do
      break if @total <= 21
      @total -= 10
    end

    @total
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name, :score

  def initialize
    @score = 0
  end
end

class Player < Participant
  def initialize
    super
    @name = "Player"
  end
end

class Dealer < Participant
  def initialize
    super
    @name = "Dealer"
  end
end

class Card
  SUITS = %w(hearts diamonds clubs spades).freeze
  VALUES = %w(2 3 4 5 6 7 8 9 10 jack queen king ace).freeze

  attr_reader :value, :suit, :actual_value

  def initialize(value, suit)
    @value = value
    @suit = suit
    set_actual_value
  end

  def set_actual_value
    @actual_value = case value
                    when value.to_i.to_s then value.to_i
                    when "jack"          then 10
                    when "queen"         then 10
                    when "king"          then 10
                    when "ace"           then 11
                    end
  end
end

class Deck
  attr_accessor :cards
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
    dealer.cards = deck.cards.sample(2)
    deck.cards.delete(dealer.cards[0])
    deck.cards.delete(dealer.cards[1])
  end

  def show_initial_cards
    puts "Player's cards are:"
    puts " - #{player.cards[0].value} of #{player.cards[0].suit}"
    puts " - #{player.cards[1].value} of #{player.cards[1].suit}"
    puts "Player has a total of #{player.total}."
    puts ""
    puts "Dealer's cards are:"
    puts " - #{dealer.cards[0].value} of #{dealer.cards[0].suit}"
    puts " - unknown card"
    puts "Dealer has a total of #{dealer.cards[0].actual_value} + ?"
  end

  def player_turn
    answer = nil
    loop do
      puts "Would you like to hit or stay? (h/s)"
      loop do
        answer = gets.chomp.downcase
        break if %w(h s).include?(answer)
        puts "Sorry, invalid answer. Type h to hit or s to stay:"
      end

      clear
      if answer == 'h'
        player.cards << deck.cards.sample
        player.hit
        deck.cards.delete(player.cards[-1])
      else
        player.stay
        break
      end

      break if player.busted?
    end
  end

  def dealer_turn
    loop do
      if dealer.total >= 17
        break if dealer.busted?
        dealer.stay
        break
      else
        dealer.cards << deck.cards.sample
        dealer.hit
        deck.cards.delete(dealer.cards[-1])
      end
    end
  end

  def winner
    if player.busted?
      :dealer
    elsif dealer.busted?
      :player
    elsif player.total > dealer.total
      :player
    elsif dealer.total > player.total
      :dealer
    end
  end

  def show_result
    puts case winner
         when :player then "Player is the winner!"
         when :dealer then "Dealer is the winner!"
         else              "It's a tie!"
         end
  end

  def update_score
    case winner
    when :player then player.score += 1
    when :dealer then dealer.score += 1
    end
  end

  def show_score
    puts "Score: Player #{player.score} X Dealer #{dealer.score}"
  end

  def clear
    system 'clear'
    system 'clc'
  end

  def display_welcome_message
    clear
    puts "Hello and welcome to Twenty-One!"
  end

  def display_goodbye_message
    puts "Thanks for playing, bye-bye!"
  end

  def play_again?
    answer = nil
    puts "Would you like to play again? (y/n)"

    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, invalid answer. Please type y for yes or n for no:"
    end

    answer == 'y'
  end

  def reset
    clear
    deck.cards = []
    deck.set_deck
  end

  def start
    display_welcome_message
    loop do
      deal_cards
      show_initial_cards
      player_turn
      dealer_turn unless player.busted?
      show_result
      update_score
      show_score
      break unless play_again?
      reset
      puts "Let's play again!"
    end
    display_goodbye_message
  end
end

Game.new.start
