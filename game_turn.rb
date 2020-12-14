require_relative 'die'
require_relative 'player'
require_relative 'treasure_trove'

module GameTurn
  def self.take_turn(player)
    roll_number = Die.new.roll
    case roll_number
    when 1..2
      player.blam
    when 3..4
      puts "#{player.name} was skipped."
    else
      player.w00t
    end
    random_loot = TreasureTrove.random
    puts "#{player.name} found a #{random_loot.name} worth #{random_loot.points}"
  end
end
