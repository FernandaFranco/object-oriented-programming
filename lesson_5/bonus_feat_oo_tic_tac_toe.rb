class Array
  def joinor(sep = ', ', last_sep = 'or')
    case size
    when 2 then join(" #{last_sep} ").to_s
    when 1 then self[0].to_s
    else
      "#{self[0...-1].join(sep)} #{last_sep} #{self[-1]}"
    end
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

  def marked_by_human_keys
    @squares.keys.select { |key| @squares[key].marked_by_human? }
  end

  def marked_by_computer_keys
    @squares.keys.select { |key| @squares[key].marked_by_computer? }
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

  def marked_by_human?
    marker == Human::HUMAN_MARKER
  end

  def marked_by_computer?
    marker == Computer::COMPUTER_MARKER
  end

  def to_s
    marker
  end
end

class Player
  WINING_SETS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]].freeze

  attr_reader :marker
  attr_accessor :marked_keys, :score, :name

  def initialize
    reset
    @score = 0
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
      puts "Choose a square (#{board.unmarked_keys.joinor}):"
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
  STANDARD_FIRST_KEY = 5
  COMPUTER_MARKER = "O".freeze

  def initialize
    super
    @marker = COMPUTER_MARKER
    set_name
  end

  def set_name
    self.name = %w(Robert Viviane Alyssa Maddie Boyle).sample
  end

  def move(board)
    key = nil

    WINING_SETS.each do |set|
      key ||= offensive_move_key(set, board) # still nil if no offense move
    end

    WINING_SETS.each do |set|
      key ||= defensive_move_key(set, board) # still nil if no defense move
    end

    key ||= if board.unmarked_keys.include?(STANDARD_FIRST_KEY)
              STANDARD_FIRST_KEY
            else
              board.unmarked_keys.sample
            end

    board[key] = marker

    marked_keys << key
  end

  private

  def offensive_move_key(set, board)
    if marked_keys.count { |k| set.include?(k) } == 2
      set.select { |k| board.unmarked_keys.include?(k) }.first
    end
  end

  def defensive_move_key(set, board)
    if board.marked_by_human_keys.count { |k| set.include?(k) } == 2
      set.select { |k| board.unmarked_keys.include?(k) }.first
    end
  end
end

class TTTGame
  FIRST_TO_MOVE = Human::HUMAN_MARKER
  WINS_TO_END_GAME = 5

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
      end

      display_result
      break if end_game? || !play_again?
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

  def set_human_name
    answer = ''
    loop do
      puts "What's your name?"
      answer = gets.chomp.capitalize
      break unless answer.empty?
      puts "Sorry, can't be empty."
    end
    clear
    human.name = answer
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!"

    set_human_name
    puts "Nice to meet you, #{human.name}! " \
         "Your opponent's name is #{computer.name}."
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe, #{human.name}. Bye-bye!"
  end

  def display_board
    puts "#{human.name} is '#{human.marker}'"
    puts "#{computer.name} is '#{computer.marker}'."
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

  def display_winner
    if human.won?
      puts "You win!"
    elsif computer.won?
      puts "Computer wins."
    else
      puts "It's a tie!"
    end
  end

  def update_score
    if human.won?
      human.score += 1
    elsif computer.won?
      computer.score += 1
    end
  end

  def display_score
    puts "Human: #{human.score} X Computer: #{computer.score}"
    if human.score == WINS_TO_END_GAME
      puts "Congratulations, you won #{WINS_TO_END_GAME} games!"
    elsif computer.score == WINS_TO_END_GAME
      puts "Computer won #{WINS_TO_END_GAME} games. Better luck next time!"
    end
  end

  def display_result
    clear_screen_and_display_board
    display_winner
    update_score
    display_score
  end

  def end_game?
    human.score == WINS_TO_END_GAME || computer.score == WINS_TO_END_GAME
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
