require_relative 'playable'

class Player
  include Playable
  attr_accessor :name
  attr_reader :health, :treasures
  def initialize(name, health=100)
    @name=name.capitalize
    @health=health
    @treasures = Hash.new(0)
  end

  def to_s
    "I'm #{@name} with a health of #{@health} and a score of #{score}"
  end

  def score
    @health + points
  end

  def points
    @treasures.values.reduce(0, :+)
  end

  def found_treasure(treasure)
    @treasures[treasure.name] += treasure.points
    puts "#{@name} found a #{treasure.name} worth #{treasure.points} points."
    puts "#{@name}'s treasures: #{@found_treasures}"
  end

  def <=>(other_player)
    other_player.health <=> @health
  end

  def each_found_treasure
    @treasures.each do |name, points|
      yield Treasure.new(name, points)
    end
  end

  def self.from_csv(csv_line)
    name, health = csv_line.split(',')
    Player.new(name, Integer(health))
  end
end

if __FILE__ == $0
  puts Player.new("pepito", 18)
end