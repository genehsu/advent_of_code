# https://adventofcode.com/2015/day/21

class Day21

  WEAPONS = [[ 8,4,0],
             [10,5,0],
             [25,6,0],
             [40,7,0],
             [74,8,0]]
  ARMOR = [[  0,0,0],
           [ 13,0,1],
           [ 31,0,2],
           [ 53,0,3],
           [ 75,0,4],
           [102,0,5]]
  RINGS = [[  0,0,0],
           [ 25,1,0],
           [ 50,2,0],
           [100,3,0],
           [ 20,0,1],
           [ 40,0,2],
           [ 80,0,3]]

  Creature = Struct.new(:hp, :damage, :armor, :cost)

  def initialize(player, boss)
    @player = player
    @boss = boss
  end

  def self.parse(input)
    /Hit Points: (?<hp>\d+)\s+Damage: (?<damage>\d+)\s+Armor: (?<armor>\d+)/ =~ input
    hp, damage, armor = [hp, damage, armor].map(&:to_i)
    Creature.new(hp, damage, armor)
  end

  def self.creatureify(stats)
    Creature.new( *stats.fetch_values(:hp, :damage, :armor) )
  end

  def self.equip(weapon, armor, ring1, ring2)
    player = Creature.new(100, 0, 0, 0)
    [weapon, armor, ring1, ring2].each do |cost, damage, armor|
      player.cost += cost
      player.damage += damage
      player.armor += armor
    end
    player
  end

  def player_win?
    player_hit = @player.damage - @boss.armor
    boss_hit = @boss.damage - @player.armor
    player_hp = @player.hp
    boss_hp = @boss.hp
    while player_hp > 0
      boss_hp -= player_hit
      break if boss_hp <= 0
      player_hp -= boss_hit
    end
    player_hp > 0
  end

  def self.ring_combos
    @ring_combos ||= RINGS.combination(2).to_a << [[0,0,0],[0,0,0]]
  end

  def self.part1(input)
    boss = parse(input)
    player = equip(WEAPONS.last, ARMOR.last, RINGS.last, RINGS.first)
    WEAPONS.map do |weapon|
      ARMOR.map do |armor|
        ring_combos.map do |ring1, ring2|
          player = equip(weapon, armor, ring1, ring2)
          fight = new player, boss
          fight.player_win? ? player.cost : 10000
        end.min
      end.min
    end.min
  end

  def self.part2(input)
    boss = parse(input)
    player = equip(WEAPONS.last, ARMOR.last, RINGS.last, RINGS.first)
    WEAPONS.map do |weapon|
      ARMOR.map do |armor|
        ring_combos.map do |ring1, ring2|
          player = equip(weapon, armor, ring1, ring2)
          fight = new player, boss
          fight.player_win? ? 0 : player.cost
        end.max
      end.max
    end.max
  end
end
