require 'openssl'
require 'securerandom'
require 'terminal-table'

class HMACGenerator
  def self.generate(key, message)
    hmac = OpenSSL::HMAC.digest(OpenSSL::Digest.new('SHA256'), key, message)
    hmac.unpack('H*').first
  end
end

class RuleBook
  def initialize(moves)
    @moves = moves
    @winning_moves = calculate_winning_moves
  end

  def winner(move1, move2)
    return 'Draw' if move1 == move2

    move1_index = @moves.index(move1)
    move2_index = @moves.index(move2)

    if @winning_moves[move1_index].include?(move2_index)
      'Win'
    else
      'Lose'
    end
  end

  private

  def calculate_winning_moves
    winning_moves = []
    moves_count = @moves.length
    half_moves_count = moves_count / 2

    @moves.each_with_index do |_, i|
      winning_moves[i] = []

      half_moves_count.times do |j|
        winning_moves[i] << (@moves.length + i + j + 1) % @moves.length
      end
    end
    winning_moves
  end
end

class MoveTable
  def initialize(moves)
    @moves = moves
    @rule_book = RuleBook.new(moves)
  end

  def generate_table
    rows = []
    rows << ['PC\User=>'] + @moves

    @moves.each_with_index do |move1, index1|
      row = [move1]
      @moves.each_with_index do |move2, index2|
        row << @rule_book.winner(move1, move2)
      end
      rows << row
    end

    Terminal::Table.new(rows: rows)
  end
end

class Game
  def initialize(moves)
    @moves = moves
    @move_table = MoveTable.new(moves)
  end

  def start
    key = SecureRandom.hex(32)
    computer_move = @moves.sample

    hmac = HMACGenerator.generate(key, computer_move)

    puts "HMAC: #{hmac}"
    puts 'Available moves:'
    @moves.each_with_index { |move, index| puts "#{index + 1} - #{move}" }
    puts '0 - exit'
    puts '? - help'

    user_move = nil
    loop do
      print 'Enter your move: '
      input = $stdin.gets.chomp
      if ARGV.length.to_i < input.to_i
        puts "Invalid input!! Please select the correct option!!"
      else
        case input
        when '0'
          exit
        when '?'
          result = @move_table.generate_table
          puts result
        else
          user_move = @moves[input.to_i - 1]
          break if user_move
        end
      end
    end

    puts "Your move: #{user_move}"
    puts "Computer move: #{computer_move}"
    rule_book = RuleBook.new(@moves)
    win = rule_book.winner(user_move, computer_move)
    puts "You "+ win
    puts "HMAC key: #{key}"
  end

end

if ARGV.length < 3 || ARGV.length.even? || ARGV.length != ARGV.uniq.length
  puts 'Invalid input. Please provide an odd number of non-repeating strings.'
  puts 'Example: ruby task3.rb rock paper scissors'
  exit
end

game = Game.new(ARGV)
game.start
