require_relative 'player'

class Game
  def initialize(name)
    @name = name
    @players = []
  end
  def add_player(player)
    @players << player
  end
  def play
    @players.each do |player|
      puts player
    end
  end
end
