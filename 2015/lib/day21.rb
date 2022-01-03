# https://adventofcode.com/2015/day/21
# --- Day 21: RPG Simulator 20XX ---

class Day21
  # Little Henry Case got a new video game for Christmas. It's an RPG, and he's
  # stuck on a boss. He needs to know what equipment to buy at the shop. He
  # hands you the controller.
  #
  # In this game, the player (you) and the enemy (the boss) take turns
  # attacking. The player always goes first. Each attack reduces the opponent's
  # hit points by at least 1. The first character at or below 0 hit points
  # loses.
  #
  # Damage dealt by an attacker each turn is equal to the attacker's damage
  # score minus the defender's armor score. An attacker always does at least 1
  # damage. So, if the attacker has a damage score of 8, and the defender has
  # an armor score of 3, the defender loses 5 hit points. If the defender had
  # an armor score of 300, the defender would still lose 1 hit point.
  #
  # Your damage score and armor score both start at zero. They can be increased
  # by buying items in exchange for gold. You start with no items and have as
  # much gold as you need. Your total damage or armor is equal to the sum of
  # those stats from all of your items. You have 100 hit points.
  #
  # Here is what the item shop is selling:
  #
  # Weapons:    Cost  Damage  Armor
  # Dagger        8     4       0
  # Shortsword   10     5       0
  # Warhammer    25     6       0
  # Longsword    40     7       0
  # Greataxe     74     8       0
  #
  # Armor:      Cost  Damage  Armor
  # Leather      13     0       1
  # Chainmail    31     0       2
  # Splintmail   53     0       3
  # Bandedmail   75     0       4
  # Platemail   102     0       5
  #
  # Rings:      Cost  Damage  Armor
  # Damage +1    25     1       0
  # Damage +2    50     2       0
  # Damage +3   100     3       0
  # Defense +1   20     0       1
  # Defense +2   40     0       2
  # Defense +3   80     0       3
  #
  # You must buy exactly one weapon; no dual-wielding. Armor is optional, but
  # you can't use more than one. You can buy 0-2 rings (at most one for each
  # hand). You must use any items you buy. The shop only has one of each item,
  # so you can't buy, for example, two rings of Damage +3.
  #
  # For example, suppose you have 8 hit points, 5 damage, and 5 armor, and that
  # the boss has 12 hit points, 7 damage, and 2 armor:
  #
  #     The player deals 5-2 = 3 damage; the boss goes down to 9 hit points.
  #     The boss deals 7-5 = 2 damage; the player goes down to 6 hit points.
  #     The player deals 5-2 = 3 damage; the boss goes down to 6 hit points.
  #     The boss deals 7-5 = 2 damage; the player goes down to 4 hit points.
  #     The player deals 5-2 = 3 damage; the boss goes down to 3 hit points.
  #     The boss deals 7-5 = 2 damage; the player goes down to 2 hit points.
  #     The player deals 5-2 = 3 damage; the boss goes down to 0 hit points.
  #
  # In this scenario, the player wins! (Barely.)
  #
  # You have 100 hit points. The boss's actual stats are in your puzzle input.
  # What is the least amount of gold you can spend and still win the fight?

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

  # Turns out the shopkeeper is working with the boss, and can persuade you to
  # buy whatever items he wants. The other rules still apply, and he still only
  # has one of each item.
  #
  # What is the most amount of gold you can spend and still lose the fight?

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
