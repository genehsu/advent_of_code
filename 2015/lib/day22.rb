# https://adventofcode.com/2015/day/22
# --- Day 22: Wizard Simulator 20XX ---

require 'pry'

class Day22
  # Little Henry Case decides that defeating bosses with swords and stuff is
  # boring. Now he's playing the game with a wizard. Of course, he gets stuck
  # on another boss and needs your help again.
  #
  # In this version, combat still proceeds with the player and the boss taking
  # alternating turns. The player still goes first. Now, however, you don't get
  # any equipment; instead, you must choose one of your spells to cast. The
  # first character at or below 0 hit points loses.
  #
  # Since you're a wizard, you don't get to wear armor, and you can't attack
  # normally. However, since you do magic damage, your opponent's armor is
  # ignored, and so the boss effectively has zero armor as well. As before, if
  # armor (from a spell, in this case) would reduce damage below 1, it becomes
  # 1 instead - that is, the boss' attacks always deal at least 1 damage.
  #
  # On each of your turns, you must select one of your spells to cast. If you
  # cannot afford to cast any spell, you lose. Spells cost mana; you start with
  # 500 mana, but have no maximum limit. You must have enough mana to cast a
  # spell, and its cost is immediately deducted when you cast it. Your spells
  # are Magic Missile, Drain, Shield, Poison, and Recharge.
  #
  #     Magic Missile costs 53 mana. It instantly does 4 damage.
  #
  #     Drain costs 73 mana. It instantly does 2 damage and heals you for 2 hit
  #     points.
  #
  #     Shield costs 113 mana. It starts an effect that lasts for 6 turns.
  #     While it is active, your armor is increased by 7.
  #
  #     Poison costs 173 mana. It starts an effect that lasts for 6 turns. At
  #     the start of each turn while it is active, it deals the boss 3 damage.
  #
  #     Recharge costs 229 mana. It starts an effect that lasts for 5 turns. At
  #     the start of each turn while it is active, it gives you 101 new mana.
  #
  # Effects all work the same way. Effects apply at the start of both the
  # player's turns and the boss' turns. Effects are created with a timer (the
  # number of turns they last); at the start of each turn, after they apply any
  # effect they have, their timer is decreased by one. If this decreases the
  # timer to zero, the effect ends. You cannot cast a spell that would start an
  # effect which is already active. However, effects can be started on the same
  # turn they end.
  #
  # For example, suppose the player has 10 hit points and 250 mana, and that
  # the boss has 13 hit points and 8 damage:
  #
  # -- Player turn --
  # - Player has 10 hit points, 0 armor, 250 mana
  # - Boss has 13 hit points
  # Player casts Poison.
  #
  # -- Boss turn --
  # - Player has 10 hit points, 0 armor, 77 mana
  # - Boss has 13 hit points
  # Poison deals 3 damage; its timer is now 5.
  # Boss attacks for 8 damage.
  #
  # -- Player turn --
  # - Player has 2 hit points, 0 armor, 77 mana
  # - Boss has 10 hit points
  # Poison deals 3 damage; its timer is now 4.
  # Player casts Magic Missile, dealing 4 damage.
  #
  # -- Boss turn --
  # - Player has 2 hit points, 0 armor, 24 mana
  # - Boss has 3 hit points
  # Poison deals 3 damage. This kills the boss, and the player wins.
  #
  # Now, suppose the same initial conditions, except that the boss has 14 hit
  # points instead:
  #
  # -- Player turn --
  # - Player has 10 hit points, 0 armor, 250 mana
  # - Boss has 14 hit points
  # Player casts Recharge.
  #
  # -- Boss turn --
  # - Player has 10 hit points, 0 armor, 21 mana
  # - Boss has 14 hit points
  # Recharge provides 101 mana; its timer is now 4.
  # Boss attacks for 8 damage!
  #
  # -- Player turn --
  # - Player has 2 hit points, 0 armor, 122 mana
  # - Boss has 14 hit points
  # Recharge provides 101 mana; its timer is now 3.
  # Player casts Shield, increasing armor by 7.
  #
  # -- Boss turn --
  # - Player has 2 hit points, 7 armor, 110 mana
  # - Boss has 14 hit points
  # Shield's timer is now 5.
  # Recharge provides 101 mana; its timer is now 2.
  # Boss attacks for 8 - 7 = 1 damage!
  #
  # -- Player turn --
  # - Player has 1 hit point, 7 armor, 211 mana
  # - Boss has 14 hit points
  # Shield's timer is now 4.
  # Recharge provides 101 mana; its timer is now 1.
  # Player casts Drain, dealing 2 damage, and healing 2 hit points.
  #
  # -- Boss turn --
  # - Player has 3 hit points, 7 armor, 239 mana
  # - Boss has 12 hit points
  # Shield's timer is now 3.
  # Recharge provides 101 mana; its timer is now 0.
  # Recharge wears off.
  # Boss attacks for 8 - 7 = 1 damage!
  #
  # -- Player turn --
  # - Player has 2 hit points, 7 armor, 340 mana
  # - Boss has 12 hit points
  # Shield's timer is now 2.
  # Player casts Poison.
  #
  # -- Boss turn --
  # - Player has 2 hit points, 7 armor, 167 mana
  # - Boss has 12 hit points
  # Shield's timer is now 1.
  # Poison deals 3 damage; its timer is now 5.
  # Boss attacks for 8 - 7 = 1 damage!
  #
  # -- Player turn --
  # - Player has 1 hit point, 7 armor, 167 mana
  # - Boss has 9 hit points
  # Shield's timer is now 0.
  # Shield wears off, decreasing armor by 7.
  # Poison deals 3 damage; its timer is now 4.
  # Player casts Magic Missile, dealing 4 damage.
  #
  # -- Boss turn --
  # - Player has 1 hit point, 0 armor, 114 mana
  # - Boss has 2 hit points
  # Poison deals 3 damage. This kills the boss, and the player wins.
  #
  # You start with 50 hit points and 500 mana points. The boss's actual stats
  # are in your puzzle input. What is the least amount of mana you can spend
  # and still win the fight? (Do not include mana recharge effects as
  # "spending" negative mana.)

  SPELLS = {
    missle: {
      cost: 53,
      damage: 4,
    },

    drain: {
      cost: 73,
      damage: 2,
      heal: 2,
    },

    shield: {
      cost: 113,
      effect: {
        attribute: :armor,
        amount: 7,
        duration: 6
      }
    },

    poison: {
      cost: 173,
      effect: {
        attribute: :damage,
        amount: 3,
        duration: 6
      }
    },

    recharge: {
      cost: 229,
      effect: {
        attribute: :mana,
        amount: 101,
        duration: 5
      }
    },
  }

  Creature = Struct.new(:hp, :mana, :armor, :damage)

  def initialize(player, boss, hardmode=false)
    @player = Creature.new(player[:hp], player[:mana], 0, 0)
    @boss = Creature.new(boss[:hp], 0, 0, boss[:damage])
    @hardmode = hardmode
  end

  def reset
    @combatant = @player.dup
    @boss_hp = @boss.hp
    @mana_cast = 0
    @status = {
      shield: 0,
      poison: 0,
      recharge: 0,
    }
  end

  def combat(spells, max_use=1000000)
    reset
    @spells = spells.dup

    while @combatant.hp > 0
      # p @combatant, @boss_hp, @spells, @status
      # Player Turn
      @combatant.hp -= 1 if @hardmode
      break unless @combatant.hp > 0
      apply_effects
      break unless @boss_hp > 0
      cost = choose_spell
      break unless cost # Ran out of spells
      @mana_cast += cost
      break if @combatant.mana < 0 # Spell too costly
      break unless @boss_hp > 0
      # Boss Turn
      apply_effects
      break unless @boss_hp > 0
      @combatant.hp -= @boss.damage - @combatant.armor
    end
    @mana_cast
  end

  def player_win?
    complete? &&
      @boss_hp <= 0 &&
      @combatant.mana >= 0
  end

  def complete?
    @combatant.mana < 0 ||
      @boss_hp <= 0 ||
      @combatant.hp <= 0
  end

  def mana_cast
    @mana_cast
  end

  def choose_spell
    spell = @spells.shift
    return unless spell
    case spell
    when :shield, :poison
      @status[spell] = 6
    when :recharge
      @status[spell] = 5
    when :missle
      @boss_hp -= 4
    when :drain
      @combatant.hp += 2
      @boss_hp -= 2
    end
    cost = SPELLS[spell][:cost]
    @combatant.mana -= cost
    cost
  end

  def apply_effects
    @combatant.armor = 0 if @status[:shield] == 0
    @status.each do |k,v|
      next if v == 0
      case k
      when :shield
        @combatant.armor = 7
      when :poison
        @boss_hp -= 3
      when :recharge
        @combatant.mana += 101
      end
      @status[k] -= 1
    end
  end

  def self.spell_cost(spells)
    spells.map { |spell| SPELLS[spell][:cost] }.sum
  end

  def self.available_spells(spells = [])
    [:missle, :drain] +
      [:shield, :recharge, :poison].reject { |spell| spells[-2] == spell || spells[-1] == spell }
  end

  def self.explore(game)
    stack = available_spells([]).map { |spell| [spell] }
    min = 1000000
    length = 0
    while spells = stack.shift
      next if spell_cost(spells) > min
      if length != spells.length
        length = spells.length
      end
      game.combat spells
      if game.player_win?
        min = [min, game.mana_cast].min
      end
      if !game.complete?
        available_spells(spells).each do |spell|
          stack << spells + [spell]
        end
      end
    end
    min
  end

  def self.part1(player, boss)
    game = new player, boss
    explore(game)
  end

  # On the next run through the game, you increase the difficulty to hard.
  #
  # At the start of each player turn (before any other effects apply), you lose
  # 1 hit point. If this brings you to or below 0 hit points, you lose.
  #
  # With the same starting stats for you and the boss, what is the least amount
  # of mana you can spend and still win the fight?

  def self.part2(player, boss)
    game = new player, boss, true
    explore(game)
  end
end
