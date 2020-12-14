require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
  def initialize(name)
    @name = name
    @players = []
  end
  def add_player(player)
    @players << player
  end

  def play(rounds)
    treasures = TreasureTrove::TREASURES
    puts "There are #{treasures.length} treasures to be found:"
    treasures.each { |t|  puts "A #{t.name} is worth #{t.points} points" }

    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
        puts player
      end
    end
  end

  def print_stats
    strong, wimpy = @players.partition{|p| p.strong?}
    puts "\nStrong:"
    puts strong
    puts "\nWimpy:"
    puts wimpy

    puts "\n#{@name} high scores:"
    @players.sort.each { |p| puts p.name.ljust(30, '.') + p.health.to_s}
  end
end
