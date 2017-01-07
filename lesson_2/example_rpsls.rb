

class Move
  def to_s
    self.class.to_s
  end

  def >(other)
    opponent = other.class.to_s
    self.class::DEFEATS.keys.include?(opponent)
  end
end

class Rock < Move
  DEFEATS = { 'Scissors' => 'crushes', 'Lizard' => 'crushes' }.freeze

  def to_sym
    :r
  end
end

class Paper < Move
  DEFEATS = { 'Rock' => 'covers', 'Spock' => 'disproves' }.freeze

  def to_sym
    :p
  end
end

class Scissors < Move
  DEFEATS = { 'Paper' => 'cut', 'Lizard' => 'decapitate' }.freeze

  def to_sym
    :s
  end
end

class Lizard < Move
  DEFEATS = { 'Paper' => 'eats', 'Spock' => 'poisons' }.freeze

  def to_sym
    :l
  end
end

class Spock < Move
  DEFEATS = { 'Scissors' => 'smashes', 'Rock' => 'vaporizes' }.freeze

  def to_sym
    :sp
  end
end

# human or computer
class Player
  attr_accessor :move, :name, :score
  MOVES = { r: Rock.new,
            p: Paper.new,
            s: Scissors.new,
            l: Lizard.new,
            sp: Spock.new,
            q: false }.freeze

  def initialize
    set_name
    @score = 0
  end

  def to_s
    name
  end
end

# for the human player
class Human < Player
  def set_name
    username = ""
    loop do
      puts "What's your name?"
      username = gets.chomp
      break unless username.empty? || username.match(/^ +$/)
      puts 'Sorry, must enter a value.'
    end
    self.name = username
  end

  def choose_move
    choice = nil
    loop do
      puts "Choose (r)ock, (p)aper, (s)cissors, (l)izard (sp)ock, or (q)uit:"
      choice = gets.chomp.downcase.to_sym
      break if MOVES.keys.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = MOVES[choice]
  end
end

# for the computer player
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Wall E', 'Sonny', 'Number 5'].sample
  end

  def choose_move(other_move, history)
    case name
    when 'R2D2' then prefers_rock
    when 'Hal' then cheat(other_move)
    when 'Wall E' then never_lizard
    when 'Sonny' then learn_from_history(history)
    when 'Number 5' then equal_weight
    end
  end

  # symbols stand for (:r)ock, (:p)aper, (:s)cissors, (:l)izard, (:sp)ock.

  def equal_weight
    choices = [:r, :p, :s, :l, :sp]
    choose(choices)
  end

  def prefers_rock
    choices = [:r, :r, :r, :r, :r, :p, :s, :l, :sp]
    choose(choices)
  end

  def never_lizard
    choices = [:r, :p, :s, :s, :s, :sp, :sp]
    choose(choices)
  end

  def cheat(other_move)
    choices = case other_move.to_s
              when 'Rock' then [:p, :sp, :r]
              when 'Paper' then [:s, :l]
              when 'Scissors' then [:r, :l] # can make a mistake
              when 'Lizard' then [:r, :s]
              when 'Spock' then [:sp, :p, :l]
              end
    choose(choices)
  end

  def learn_from_history(history)
    choices = [:r, :r, :p, :p, :s, :s, :l, :l, :sp, :sp]
    # start with equal chance for all moves

    wins = history.select { |round| round[:winner] == name }
    wins.each { |round| choices.push(round[:win_move].to_sym) }
    # increases chance for moves that previously led to wins

    losses = history.select { |round| round[:loser] == name }
    losses.each { |round| choices -= [round[:lose_move].to_sym] }
    # decreases chance for moves that previously led to losses

    choose(choices)
  end

  def choose(choices)
    self.move = MOVES[choices.sample]
  end
end

# Game orchestration engine:
class RPSGame
  WIN = 6
  GAME_NAME = "Rock Paper Scissors Lizard Spock".freeze
  attr_accessor :human, :computer, :round_num

  def initialize
    @history = []
    @round_num = 1
  end

  def play
    start_new_game
    loop do
      display_score
      break unless human.choose_move
      computer.choose_move(human.move, @history)
      winner = calculate_winner
      save_round(winner)
      display_history
      comment_on_win(winner) if winner != 'tie' && winner.score == WIN
    end
    display_goodbye_message
  end

  def start_new_game
    clear_screen
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    puts "First player to #{WIN} points wins."
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to #{GAME_NAME}!"
  end

  def calculate_winner
    if human.move > computer.move
      human.score += 1
      human
    elsif computer.move > human.move
      computer.score += 1
      computer
    else
      'tie'
    end
  end

  def display_score
    puts "\n#{human.name}: #{human.score}   #{computer.name}: #{computer.score}"
    puts
  end

  def save_round(winner)
    round = { number: round_num, winner: winner.to_s }
    if winner == 'tie'
      round[:moves] = human.move
    else
      loser = ([human, computer] - [winner]).first
      round[:verb] = detect_verb(winner, loser)
      round[:win_move] = winner.move
      round[:lose_move] = loser.move
      round[:loser] = loser.to_s
    end
    @history.push(round)
    @round_num += 1
  end

  def detect_verb(winner, loser)
    winner.move.class::DEFEATS[loser.move.to_s]
  end

  def display_history
    clear_screen
    puts
    @history.each do |round| # history is an array of hashes
      if round[:winner] == 'tie'
        puts "Round #{round[:number]}: " \
             "Tie. Both chose #{round[:moves]}."
      else
        puts "Round #{round[:number]}: " \
              "#{round[:winner]}'s #{round[:win_move]} #{round[:verb]} " \
              "#{round[:loser]}'s #{round[:lose_move]}."
      end
    end
    puts
  end

  def comment_on_win(winner)
    display_score
    puts "\n#{winner.name} wins!!!\n "
    reset
  end

  def reset
    human.score = 0
    computer.score = 0
    @history = []
    self.round_num = 1
    puts "Scores have been reset to 0."
  end

  def display_goodbye_message
    puts "Thanks for playing #{GAME_NAME}!"
  end
end

RPSGame.new.play