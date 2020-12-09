require 'rspec'
require_relative 'player'

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
    expect(@player.to_s).eql?"I'm Larry with a health of 150 and a score of 155"
  end

  it "computes a score as the sum of its health and length of name" do
    expect(@player.score).eql? @initial_health + @player.name.length
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
end
