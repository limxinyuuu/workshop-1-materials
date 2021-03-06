#
# This is a final version of the game. What I did here was just to organize the
# code a bit more. I will not write the details here, I leave it for you as an
# exercise to try to understand what changed in this program. Pay attention to
# the History class, try to understand what it does.
#
# If you reached this program, you must have been very persistent.
# Congratulations, and thank you for reading this material! :)
#

class Game
  attr_reader :number_of_tries, :player_name

  def initialize(maximum_number=10)
    @maximum_number = maximum_number
    @secret = rand(@maximum_number+1)
    @number_of_tries = 0
    @previous_tries = []
    @player_name = ask_for_name
  end

  def ask_for_name
    puts "What is your name"
    return gets.chomp
  end

  def ask_for_number
    puts "Pick number between 0 and #{@maximum_number}:"
    return gets.to_i
  end

  def run
    loop do
      @number_of_tries += 1
      guess = ask_for_number
      @previous_tries << guess
      if @secret > guess
        puts "Your number was too small"
      elsif @secret < guess
        puts "Your number was too big"
      else
        puts "#{@player_name}, your number was right!"
        puts "You tried #{@number_of_tries} times"
        puts "Your tries were: #{@previous_tries.join(', ')}"
        break
      end
    end
  end
end

class History
  def initialize
    @storage = {}
  end

  def add_score(player, score)
    @storage[player] = score
  end

  def print
    puts "\n\nGAME LEADERS\n\n"
    @storage.each do |player, score|
      puts "#{player} won in #{score} tries"
    end
    puts "\n\nEND\n\n"
  end
end

@history = History.new

def play_game(game)
  game.run
  @history.add_score(game.player_name, game.number_of_tries)
  @history.print
end

loop do
  puts "What do you want to do"
  puts "1 - play easy"
  puts "2 - play medium"
  puts "3 - play difficult"
  puts "0 - exit"

  choice = gets.to_i

  if choice == 1
    play_game(Game.new)
  elsif choice == 2
    play_game(Game.new(200))
  elsif choice == 3
    play_game(Game.new(300))
  elsif choice == 0
    break
  end
end
