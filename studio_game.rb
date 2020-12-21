require_relative 'game'

# player1 = Player.new("moe")
# player2 = Player.new("larry", 60)
# player3 = Player.new("curly", 125)


knuckleheads = Game.new("Knuckleheads")
# knuckleheads.add_player(player1)
# knuckleheads.add_player(player2)
# knuckleheads.add_player(player3)

knuckleheads.load_players(ARGV.shift || "players.csv")

loop do
  puts "\nHow many game rounds? ('quit' to exit)"
  number_rounds = gets.chomp.downcase
  case number_rounds
  when /^\d+$/
    knuckleheads.play(number_rounds.to_i)
  when 'quit',  'exit'
    knuckleheads.print_stats
    knuckleheads.save_high_scores
    break
  else
    puts "please enter number of exit"
  end

end

