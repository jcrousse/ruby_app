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

  def high_score_entry(player)
    formatted_name = player.name.ljust(20, '.')
    "#{formatted_name} #{player.score}"
  end

  def save_high_scores(to_file="high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@title} High Scores:"
      @players.each do |player|
        file.puts high_score_entry(player)
      end
    end

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

    @players.each do |player|
      puts "\n#{player.name}'s point totals:"
      puts "#{player.points} grand total points"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
    end
  end

  def load_players(csv_file)
    File.readlines(csv_file).each do |line|
      add_player(Player.from_csv(line))
    end
  end

end
