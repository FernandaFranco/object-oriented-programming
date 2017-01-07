def clear_screen
  system('clear') || system('cls')
end

class Score
  END_GAME_SCORE = 3

  attr_reader :value

  def initialize
    @value = 0
  end

  def update
    @value += 1
  end

  def to_s
    value.to_s
  end
end

class History
  def initialize
    @history = []
  end

  def update(move)
    @history << move
  end

  def to_s
    @history.join(',')
  end
end

# class Rock < Move
# end

# class Paper < Move
# end

# class Scissors < Move
# end

# class Lizard < Move
# end

# class Spock < Move
# end

class Move
  VALUES = %w(rock paper scissors lizard spock).freeze

  WINING_LOSING_PAIRS = [['rock', 'scissors'],
                         ['scissors', 'paper'],
                         ['paper', 'rock'],
                         ['rock', 'lizard'],
                         ['lizard', 'spock'],
                         ['spock', 'rock'],
                         ['scissors', 'lizard'],
                         ['lizard', 'paper'],
                         ['paper', 'spock'],
                         ['spock', 'scissors']].freeze

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
  attr_accessor :move, :name, :score, :history

  def initialize
    # maybe a "name"? what about a "move"?
    set_name
    @score = Score.new
    @history = History.new
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      clear_screen
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
      puts "Choose a move: (rock/paper/scissors/lizard/spock)"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Invalid choice. Please enter 'rock', 'paper', 'scissors', " \
           "'lizard' or 'spock'."
    end
    self.move = Move.new(choice)
    history.update(move)
  end
end

class Computer < Player
  def set_name
    self.name = %w(C3po R2d2 Bb8).sample
  end

  # def choose
  #   choice = Move::VALUES.sample
  #   self.move = Move.new(choice)
  #   history.update(move)
  # end
  
  def choose
    choice = case name
             when "C3po" then %w(rock rock rock paper spock).sample
             when "R2d2" then "spock"
             when "Bb8" then %w(lizard scissors).sample
             end
    self.move = Move.new(choice)
    history.update(move)
  end
  
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPSLS, #{human.name}! " \
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

  def update_score
    case winner
    when :human then human.score.update
    when :computer then computer.score.update
    end
  end

  def display_score
    puts "Score: #{human.name} #{human.score} X " \
         "#{computer.name} #{computer.score}"
  end

  def display_final_winner
    if human.score.value > computer.score.value
      puts "#{human.name} is the winner! Congratulations!"
    elsif computer.score.value > human.score.value
      puts "#{computer.name} is the winner! Better luck next time."
    else
      puts "It's a tie! Nobody wins."
    end
  end

  def end_game?
    human.score.value == Score::END_GAME_SCORE ||
      computer.score.value == Score::END_GAME_SCORE
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer)
      puts "Sorry, invalid answer. Enter 'y' for yes or 'n' for no."
    end

    answer == 'y'
  end

  def play
    clear_screen
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_choices
      display_winner
      update_score
      display_score
      break if end_game?
      break unless play_again?
      clear_screen
      display_score
    end
    display_final_winner
    display_goodbye_message
  end
end

RPSGame.new.play
