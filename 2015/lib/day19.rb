# https://adventofcode.com/2015/day/19
# --- Day 19: Medicine for Rudolph ---

class Day19
  # Rudolph the Red-Nosed Reindeer is sick! His nose isn't shining very
  # brightly, and he needs medicine.
  #
  # Red-Nosed Reindeer biology isn't similar to regular reindeer biology;
  # Rudolph is going to need custom-made medicine. Unfortunately, Red-Nosed
  # Reindeer chemistry isn't similar to regular reindeer chemistry, either.
  #
  # The North Pole is equipped with a Red-Nosed Reindeer nuclear fusion/fission
  # plant, capable of constructing any Red-Nosed Reindeer molecule you need. It
  # works by starting with some input molecule and then doing a series of
  # replacements, one per step, until it has the right molecule.
  #
  # However, the machine has to be calibrated before it can be used.
  # Calibration involves determining the number of molecules that can be
  # generated in one step from a given starting point.
  #
  # For example, imagine a simpler machine that supports only the following
  # replacements:
  #
  # H => HO
  # H => OH
  # O => HH
  #
  # Given the replacements above and starting with HOH, the following molecules
  # could be generated:
  #
  #     HOOH (via H => HO on the first H).
  #     HOHO (via H => HO on the second H).
  #     OHOH (via H => OH on the first H).
  #     HOOH (via H => OH on the second H).
  #     HHHH (via O => HH).
  #
  # So, in the example above, there are 4 distinct molecules (not five, because
  # HOOH appears twice) after one replacement from HOH. Santa's favorite
  # molecule, HOHOHO, can become 7 distinct molecules (over nine replacements:
  # six from H, and three from O).
  #
  # The machine replaces without regard for the surrounding characters. For
  # example, given the string H2O, the transition H => OO would result in OO2O.
  #
  # Your puzzle input describes all of the possible replacements and, at the
  # bottom, the medicine molecule for which you need to calibrate the machine.
  # How many distinct molecules can be created after all the different ways you
  # can do one replacement on the medicine molecule?

  def self.parse_replacements(replace_inputs)
    subs = Hash.new { |h,k| h[k] = [] }
    replace_inputs.map do |line|
      /^(?<target>\w+) => (?<replacement>\w+)$/ =~ line
      subs[target] << replacement
    end
    subs
  end

  def self.part1(input, replace_inputs)
    subs = parse_replacements replace_inputs
    molecules = {}

    subs.each do |target, replacements|
      offset = 0
      while pos = input.index(target, offset)
        replacements.each do |replacement|
          copy = input.dup
          copy[pos, target.size] = replacement
          molecules[copy] = true
        end
        offset = pos + 1
      end
    end
    molecules.size
  end

  # Now that the machine is calibrated, you're ready to begin molecule
  # fabrication.
  #
  # Molecule fabrication always begins with just a single electron, e, and
  # applying replacements one at a time, just like the ones during calibration.
  #
  # For example, suppose you have the following replacements:
  #
  # e => H
  # e => O
  # H => HO
  # H => OH
  # O => HH
  #
  # If you'd like to make HOH, you start with e, and then make the following
  # replacements:
  #
  #     e => O to get O
  #     O => HH to get HH
  #     H => OH (on the second H) to get HOH
  #
  # So, you could make HOH after 3 steps. Santa's favorite molecule, HOHOHO,
  # can be made in 6 steps.
  #
  # How long will it take to make the medicine? Given the available
  # replacements and the medicine molecule in your puzzle input, what is the
  # fewest number of steps to go from e to the medicine molecule?

  def self.parse_inverse_replacements(replace_inputs)
    replace_inputs.map do |line|
      /^(?<target>\w+) => (?<replacement>\w+)$/ =~ line
      [replacement, target]
    end.to_h
  end

  def self.part2(input, replace_inputs)
    subs = parse_inverse_replacements replace_inputs
    replacements = subs.keys
      .sort_by { |x| -x.length }
      .map { |s| Regexp.new(s) }
    depth = 0
    substrate = input

    while substrate != 'e'
      replacements.each do |replacement|
        next unless replacement =~ substrate
        target = subs[replacement.source]
        substrate = substrate.sub(replacement, target)
        depth += 1
        break
      end
    end
    depth
  end
end
