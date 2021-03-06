# description: tic tac toe is a game with two players who must decide who is X
# and who is O, also who is gonna start playing first. Then the first player
# makes his move on a 3 by 3 board and chooses a square. The second player then
# chooses a empty square. The game repeats until there are no more empty squares
# or one of the players marks an entire row, column or diagonal in the board.

# player
# - play
# - mark

# board

# square

class Player
  WINING_SETS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze

  attr_reader :marker
  attr_accessor :marked_keys

  def initialize
    reset
  end

  def won?
    WINING_SETS.each do |set|
      if marked_keys.include?(set[0]) &&
         marked_keys.include?(set[1]) &&
         marked_keys.include?(set[2])
        return true
      end
    end

    false
  end

  def reset
    @marked_keys = []
  end
end

class Human < Player
  HUMAN_MARKER = "X".freeze

  def initialize
    super
    @marker = HUMAN_MARKER
  end

  def move(board)
    key = nil

    loop do
      puts "Choose a square (#{board.unmarked_keys.join(', ')}):"
      key = gets.chomp.to_i
      if board.unmarked_keys.include?(key)
        break
      elsif (1..9).cover?(key)
        puts "Sorry, the square has already been marked."
      else
        puts "Sorry, invalid input."
      end
    end
    board[key] = marker

    marked_keys << key
  end
end

class Computer < Player
  COMPUTER_MARKER = "O".freeze

  def initialize
    super
    @marker = COMPUTER_MARKER
  end

  def move(board)
    key = board.unmarked_keys.sample
    board[key] = marker

    marked_keys << key
  end
end

class Board
  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |     "
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |     "
    puts "-----+-----+-----"
    puts "     |     |     "
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |     "
  end
  # rubocop:enable Metrics/AbcSize

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def to_s
    marker
  end
end

class TTTGame
  FIRST_TO_MOVE = Human::HUMAN_MARKER

  attr_reader :board, :human, :computer
  attr_accessor :turn

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @turn = FIRST_TO_MOVE
  end

  def play
    display_welcome_message
    loop do
      display_board

      loop do
        current_player_moves
        clear_screen_and_display_board if human_turn?
        break if someone_won? || board.full?

        # human.move(board)
        # break if someone_won? || board.full?

        # computer.move(board)
        # clear_screen_and_display_board
        # break if someone_won? || board.full?
      end

      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def clear
    system('clear')
    system('clc')
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe. Bye-bye!"
  end

  def display_board
    puts "You are '#{human.marker}'. Computer is '#{computer.marker}'."
    puts ""
    board.draw
    puts ""
  end

  def clear_screen_and_display_board
    clear
    puts ''

    display_board
  end

  def someone_won?
    human.won? || computer.won?
  end

  def display_result
    clear_screen_and_display_board

    if human.won?
      puts "Congratulations! You're the winner!"
    elsif computer.won?
      puts "Computer is the winner. Better luck next time!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, invalid input."
    end

    answer == 'y'
  end

  def reset
    board.reset
    human.reset
    computer.reset
    self.turn = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def human_turn?
    turn == Human::HUMAN_MARKER
  end

  def current_player_moves
    if human_turn?
      human.move(board)
      self.turn = Computer::COMPUTER_MARKER
    else
      computer.move(board)
      self.turn = Human::HUMAN_MARKER
    end
  end
end

game = TTTGame.new
game.play
