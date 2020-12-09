require_relative 'player'
require_relative 'die'
require_relative 'game_turn'

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
      GameTurn.take_turn(player)
      puts player
    end
  end
end
