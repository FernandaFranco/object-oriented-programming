class Score
end

class Move
  VALUES = %w(rock paper scissors).freeze

  WINING_LOSING_PAIRS = [['rock', 'scissors'],
                         ['scissors', 'paper'],
                         ['paper', 'rock']].freeze

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINING_LOSING_PAIRS.include?([value, other_move.value])
  end

  def to_s
    value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    # maybe a "name"? what about a "move"?
    set_name
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, can't be empty."
    end

    self.name = name.capitalize
  end

  def choose
    choice = nil
    loop do
      puts "Choose a move: (rock/paper/scissors)"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Invalid choice. Please enter 'rock', 'paper' or 'scissors'."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(C-3PO R2-D2 BB-8).sample
  end

  def choose
    choice = Move::VALUES.sample
    self.move = Move.new(choice)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to 'Rock, Paper, Scissors', #{human.name}! " \
         "Your opponent's name is #{computer.name}."
  end

  def display_goodbye_message
    puts "Good-bye!"
  end

  def winner
    if human.move > computer.move
      :human
    elsif computer.move > human.move
      :computer
    else
      :tie
    end
  end

  def display_choices
    puts "#{human.name} chose #{human.move}. " \
         "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    case winner
    when :human then puts "#{human.name} wins!"
    when :computer then puts "#{computer.name} wins!"
    when :tie then puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (yes/no)"
      answer = gets.chomp
      break if ['yes', 'no'].include?(answer)
      puts "Sorry, invalid answer. Enter 'yes or 'no'."
    end

    answer == 'yes'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_choices
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
