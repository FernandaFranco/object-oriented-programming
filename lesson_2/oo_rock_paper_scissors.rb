# in this game, the user enter his/her choice, the computer randomly selects its
# move, the choices are compared and displayed and the winner is displayed.

# user
# choice
# computer
# random_selection
# compare_and_display
# display_winner

class Player
  attr_accessor :move, :name
  
  def initialize
    set_name
  end

end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "Please enter your name:"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "No name was entered."
    end
    self.name = n
  end
  
  def choose
    choice = ""
    loop do 
      puts "Choose one: (rock/paper/scissors)"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Invalid choice. Please enter 'rock', 'paper' or 'scissors'."
    end
    self.move = Move.new(choice)
    
  end
end

class Computer < Player
  def set_name
    self.name = ['Brian', 'Hugo', 'Sarah', 'Bianca'].sample
  end
  
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class Move
  VALUES = %w(rock paper scissors)

  attr_reader :value

  def initialize(value)
    @value = value
  end

  def rock?
    value == 'rock'
  end

  def paper?
    value == 'paper'
  end

  def scissors?
    value == 'scissors'
  end

  def >(other_move)
    if rock?
      other_move.scissors?
    elsif paper?
      other_move.rock?
    elsif scissors?
      other_move.paper?
    end
  end

  def <(other_move)
    if rock?
      other_move.paper?
    elsif paper?
      other_move.scissors?
    elsif scissors?
      other_move.rock?
    end
  end

  def to_s
    value
  end

end

class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Human.new
    @computer = Computer.new
  end
  
  def compare(move1, move2)
  end
  
  def display_welcome_message
    puts "Welcome #{self.human.name}! Your opponent's name is #{self.computer.name}."
  end
  
  def display_goodbye_message
    puts "See ya!"
  end
  
  def display_results
    puts "#{human.name} chose #{self.human.move}. #{computer.name} chose #{self.computer.move}."
  end
  
  # def tie?
  #   self.human.move == self.computer.move
  # end
  
  # WINS =[["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]
  
  # def winner_is_human?
  #   WINS.include?([self.human.move, self.computer.move])
  # end
  
  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end

    # if tie?
    #   puts "It's a tie!"
    # elsif winner_is_human?
    #   puts "#{human.name} wins!"
    # else
    #   puts "#{computer.name} wins!"
    # end
  end

  def play_again?
    answer = ''
    loop do
      puts "Do you wanna play again? (yes/no)"
      answer = gets.chomp.downcase
      break if ["yes", "no"].include?(answer)
      puts "Invalid answer. Please enter 'yes' or 'no'."
    end
    answer == "yes"
  end
  
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_results
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play