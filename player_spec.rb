require 'rspec'
require_relative 'player'
require_relative 'treasure_trove'

describe Player do
  before do
    @initial_health = 150
    @player = Player.new("larry", @initial_health)
  end

  it "has a capitalized name" do
    expect(@player.name).eql? "Larry"
  end

  it "has an initial health" do
    expect(@player.health).eql? 150
  end

  it "has a string representation" do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    expect(@player.to_s).eql?"I'm Larry with a health of 150 and a score of 250"
  end

  it "computes a score as the sum of its health and points" do
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:hammer, 50))

    @player.score.should == 250
  end

  it "increases health by 15 when w00ted" do
    @player.w00t
    expect(@player.health).eql? @initial_health - 15
  end

  context "sub_test_context" do
    it "decreases health by 10 when blammed" do
      @player.blam
      expect(@player.health).eql? @initial_health - 10
    end
  end

  context "strong player" do
    before do
      @initial_health = 150
      @player = Player.new('Gonzalo', @initial_health)
    end
    it "is strong, so strong" do
      expect(@player.strong?)
    end
  end
  context "not so strong player" do
    before do
      @initial_health = 50
      @player = Player.new('Pedro', @initial_health)
    end
    it "it is weak" do
      not expect(@player.strong?)
    end
  end

  it "computes points as the sum of all treasure points" do
    @player.points.should == 0

    @player.found_treasure(Treasure.new(:hammer, 50))

    @player.points.should == 50

    @player.found_treasure(Treasure.new(:crowbar, 400))

    @player.points.should == 450

    @player.found_treasure(Treasure.new(:hammer, 50))

    @player.points.should == 500
  end

  it "yields each found treasure and its total points" do
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:skillet, 100))
    @player.found_treasure(Treasure.new(:hammer, 50))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))
    @player.found_treasure(Treasure.new(:bottle, 5))

    yielded = []
    @player.each_found_treasure do |treasure|
      yielded << treasure
    end

    yielded.should == [
      Treasure.new(:skillet, 200),
      Treasure.new(:hammer, 50),
      Treasure.new(:bottle, 25)
    ]
  end

  it "can be created from a CSV string" do
    player = Player.from_csv("larry,150")

    player.name.should == "Larry"
    player.health.should == 150
  end

end
