# https://adventofcode.com/2015/day/22

class Day22

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

  def initialize(player, input, hardmode=false)
    @player = Creature.new(player[:hp], player[:mana], 0, 0)
    /Hit Points: (?<hp>\d+)\s+Damage: (?<damage>\d+)/ =~ input
    @boss = Creature.new(hp.to_i, 0, 0, damage.to_i)
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

  def self.part1(player, input)
    game = new player, input
    explore(game)
  end

  def self.part2(player, input)
    game = new player, input, true
    explore(game)
  end
end
