# description: tic tac toe is a game with two players who must decide who is X and
# who is O, also who is gonna start playing first. Then the first player makes his
# move on a 3 by 3 board and chooses a square. The second player then chooses a empty
# square. The game repeats until there are no more empty slots or one of the players
# marks an entire row, column or diagonal in the board.

# player
# - play
# - mark

# board

# square


class Player
  attr_reader :marker
end

class Human < Player

  def initialize
    @marker = "X"
  end

  def move(board)
    puts "Choose a square between 1-9:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Sorry, must be an integer between 1 and 9, inclusive:"
    end

    board.set_square_at(square, marker)
  end
end

class Computer < Player
  def initialize
    @marker = "O"
  end
end

class Board
  INITIAL_MARKER = ' '

  def initialize
    @squares = {}
    (1..9).each {|key| @squares[key] = Square.new(INITIAL_MARKER)}
  end

  def get_square_at(key)
    @squares[key]
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Bye-bye!"
  end

  def display_board
    puts "     |     |     "
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.
    get_square_at(3)}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.
    get_square_at(6)}  "
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.
    get_square_at(9)}  "
    puts "     |     |     "

  end

  def play
    display_welcome_message
    loop do
      display_board
      human.move(board)
      display_board
      break
      break if someone_won? || board_full?

      computer.move(board)
      break if someone_won? || board_full?
    end

    #display_result
    display_goodbye_message
  end
end


game = TTTGame.new
game.play