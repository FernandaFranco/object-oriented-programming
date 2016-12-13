# in this game, the user enter his/her choice, the computer randomly selects its
# move, the choices are compared and displayed and the winner is displayed.

# user
# choice
# computer
# random_selection
# compare_and_display
# display_winner

class Player
  attr_reader :player_type
  attr_accessor :move
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
  end
  
  def choose
    if human?
      choice = ""
      loop do 
        puts "Choose one: Rock, Paper, Scissors"
        choice = gets.chomp
        break if ["rock", "paper", "scissors"].include?(choice)
        puts "Invalid choice"
      end
      self.move = choice
    else
      self.move = ["rock", "paper", "scissors"].sample
    end
  end
  
  def human?
    self.player_type == :human
  end
end

class Move
  def initialize
  end
end

class Rule
  def initialize
  end
end

class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end
  
  def compare(move1, move2)
  end
  
  def display_welcome_message
    puts "Welcome!"
  end
  
  def display_goodbye_message
    puts "See ya!"
  end
  
  def display_results
    puts "You chose #{self.human.move}. Computer chose #{self.computer.move}."
  end
  
  def tie?
    self.human.move == self.computer.move
  end
  
  WINS =[["rock", "scissors"], ["scissors", "paper"], ["paper", "rock"]]
  
  def winner_is_human?
    WINS.include?([self.human.move, self.computer.move])
  end
  
  def display_winner
    if tie?
      puts "It's a tie!"
    elsif winner_is_human?
      puts "You win!"
    else
      puts "Computer wins!"
    end
  end

  def play_again?
    answer = ''
    loop do
      puts "Do you wanna play again?"
      answer = gets.chomp.downcase
      break if ["yes", "no"].include?(answer)
      puts "Invalid answer. Please enter yes/no"
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