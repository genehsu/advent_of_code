# https://adventofcode.com/2021/day/23
# --- Day 23: Amphipod ---
# frozen_string_literal: true

class Day23
  # A group of amphipods notice your fancy submarine and flag you down. "With
  # such an impressive shell," one amphipod says, "surely you can help us with
  # a question that has stumped our best scientists."
  #
  # They go on to explain that a group of timid, stubborn amphipods live in a
  # nearby burrow. Four types of amphipods live there: Amber (A), Bronze (B),
  # Copper (C), and Desert (D). They live in a burrow that consists of a
  # hallway and four side rooms. The side rooms are initially full of
  # amphipods, and the hallway is initially empty.
  #
  # They give you a diagram of the situation (your puzzle input), including
  # locations of each amphipod (A, B, C, or D, each of which is occupying an
  # otherwise open space), walls (#), and open space (.).
  #
  # For example:
  #
  # #############
  # #...........#
  # ###B#C#B#D###
  #   #A#D#C#A#
  #   #########
  #
  # The amphipods would like a method to organize every amphipod into side
  # rooms so that each side room contains one type of amphipod and the types
  # are sorted A-D going left to right, like this:
  #
  # #############
  # #...........#
  # ###A#B#C#D###
  #   #A#B#C#D#
  #   #########
  #
  # Amphipods can move up, down, left, or right so long as they are moving into
  # an unoccupied open space. Each type of amphipod requires a different amount
  # of energy to move one step: Amber amphipods require 1 energy per step,
  # Bronze amphipods require 10 energy, Copper amphipods require 100, and
  # Desert ones require 1000. The amphipods would like you to find a way to
  # organize the amphipods that requires the least total energy.
  #
  # However, because they are timid and stubborn, the amphipods have some extra rules:
  #
  #     Amphipods will never stop on the space immediately outside any room.
  #     They can move into that space so long as they immediately continue
  #     moving. (Specifically, this refers to the four open spaces in the
  #     hallway that are directly above an amphipod starting position.)
  #
  #     Amphipods will never move from the hallway into a room unless that room
  #     is their destination room and that room contains no amphipods which do
  #     not also have that room as their own destination. If an amphipod's
  #     starting room is not its destination room, it can stay in that room
  #     until it leaves the room. (For example, an Amber amphipod will not move
  #     from the hallway into the right three rooms, and will only move into
  #     the leftmost room if that room is empty or if it only contains other
  #     Amber amphipods.)
  #
  #     Once an amphipod stops moving in the hallway, it will stay in that spot
  #     until it can move into a room. (That is, once any amphipod starts
  #     moving, any other amphipods currently in the hallway are locked in
  #     place and will not move again until they can move fully into a room.)
  #
  # In the above example, the amphipods can be organized using a minimum of
  # 12521 energy. One way to do this is shown below.
  #
  # Starting configuration:
  #
  # #############
  # #...........#
  # ###B#C#B#D###
  #   #A#D#C#A#
  #   #########
  #
  # One Bronze amphipod moves into the hallway, taking 4 steps and using 40
  # energy:
  #
  # #############
  # #...B.......#
  # ###B#C#.#D###
  #   #A#D#C#A#
  #   #########
  #
  # The only Copper amphipod not in its side room moves there, taking 4 steps
  # and using 400 energy:
  #
  # #############
  # #...B.......#
  # ###B#.#C#D###
  #   #A#D#C#A#
  #   #########
  #
  # A Desert amphipod moves out of the way, taking 3 steps and using 3000
  # energy, and then the Bronze amphipod takes its place, taking 3 steps and
  # using 30 energy:
  #
  # #############
  # #.....D.....#
  # ###B#.#C#D###
  #   #A#B#C#A#
  #   #########
  #
  # The leftmost Bronze amphipod moves to its room using 40 energy:
  #
  # #############
  # #.....D.....#
  # ###.#B#C#D###
  #   #A#B#C#A#
  #   #########
  #
  # Both amphipods in the rightmost room move into the hallway, using 2003
  # energy in total:
  #
  # #############
  # #.....D.D.A.#
  # ###.#B#C#.###
  #   #A#B#C#.#
  #   #########
  #
  # Both Desert amphipods move into the rightmost room using 7000 energy:
  #
  # #############
  # #.........A.#
  # ###.#B#C#D###
  #   #A#B#C#D#
  #   #########
  #
  # Finally, the last Amber amphipod moves into its room, using 8 energy:
  #
  # #############
  # #...........#
  # ###A#B#C#D###
  #   #A#B#C#D#
  #   #########
  #
  # What is the least energy required to organize the amphipods?

  class Board
    COST = {
      '.' => 0,
      'A' => 1,
      'B' => 10,
      'C' => 100,
      'D' => 1000,
    }

    HOME = {
      0 => 'A',
      1 => 'B',
      2 => 'C',
      3 => 'D',
    }

    MOVES = {
      [0, 0] =>  3,
      [0, 1] =>  2,
      [0, 2] =>  2,
      [0, 3] =>  4,
      [0, 4] =>  6,
      [0, 5] =>  8,
      [0, 6] =>  9,
      [1, 0] =>  5,
      [1, 1] =>  4,
      [1, 2] =>  2,
      [1, 3] =>  2,
      [1, 4] =>  4,
      [1, 5] =>  6,
      [1, 6] =>  7,
      [2, 0] =>  7,
      [2, 1] =>  6,
      [2, 2] =>  4,
      [2, 3] =>  2,
      [2, 4] =>  2,
      [2, 5] =>  4,
      [2, 6] =>  5,
      [3, 0] =>  9,
      [3, 1] =>  8,
      [3, 2] =>  6,
      [3, 3] =>  4,
      [3, 4] =>  2,
      [3, 5] =>  2,
      [3, 6] =>  3,
    }

    BLOCKED = {
      [0, 0] => [1],
      [0, 1] => [],
      [0, 2] => [],
      [0, 3] => [2],
      [0, 4] => [2,3],
      [0, 5] => [2,3,4],
      [0, 6] => [2,3,4,5],
      [1, 0] => [1,2],
      [1, 1] => [2],
      [1, 2] => [],
      [1, 3] => [],
      [1, 4] => [3],
      [1, 5] => [3,4],
      [1, 6] => [3,4,5],
      [2, 0] => [1,2,3],
      [2, 1] => [2,3],
      [2, 2] => [3],
      [2, 3] => [],
      [2, 4] => [],
      [2, 5] => [4],
      [2, 6] => [4,5],
      [3, 0] => [1,2,3,4],
      [3, 1] => [2,3,4],
      [3, 2] => [3,4],
      [3, 3] => [4],
      [3, 4] => [],
      [3, 5] => [],
      [3, 6] => [5],
    }

    ROOM = (0..3).to_a
    HALL = (0..6).to_a
    EMPTY_SPACE = '.'

    attr_accessor :state, :room_size

    def initialize(input)
      @state = []
      (0...input.size).each do |i|
        temp = []
        (0...input[i].size).each do |j|
          if ('A'..'D').include? input[i][j]
            temp << input[i][j]
          end
        end
        @state << temp unless temp.empty?
      end
      @state = @state.transpose
      @state << Array.new(7, EMPTY_SPACE)
      @room_size = @state[0].size
    end

    def valid_moves
      {}.tap do |moves|
        ROOM.each do |r|
          # find the first space with an amphipod
          depth = room_size
          max_index = room_size - 1
          state[r].each_with_index do |c, i|
            if c != EMPTY_SPACE
              depth = i
              break
            end
          end

          # Check if the room is homed (or empty)
          home = max_index.downto(depth).all? { |i| state[r][i] == HOME[r] }

          # Move the amphipod from the room to the hall if its not homed
          if (0..max_index).include?(depth) && !home
            HALL.each do |h|
              next unless state[4][h] == EMPTY_SPACE
              next if BLOCKED[[r, h]].any? { |i| state[4][i] != EMPTY_SPACE }

              moves[[r, depth, h]] = (MOVES[[r, h]] + depth) * COST[state[r][depth]]
            end
          end

          # Move amphipod from hall to its home
          if (1..room_size).include?(depth) && home
            empty_index = depth - 1
            HALL.each do |h|
              # Must be the correct amphipod
              next unless state[4][h] == HOME[r]
              next if BLOCKED[[r, h]].any? { |i| state[4][i] != EMPTY_SPACE }

              moves[[r, empty_index, h]] = (MOVES[[r, h]] + empty_index) * COST[HOME[r]]
            end
          end
        end
      end
    end

    def next_states
      valid_moves.map do |(r, depth, h), cost|
        state = @state.map { |e| e.dup }
        state[r][depth], state[4][h] = state[4][h], state[r][depth]
        [cost, state]
      end
    end

    def to_s
      ["#############",
       "##{state[4][0]}#{state[4][1..5].join(EMPTY_SPACE)}#{state[4][6]}#",
       (0...state[0].size).map do |i|
         prefix = i == 0 ? '###' : '  #'
         suffix = i == 0 ? '###' : '#'
         "#{prefix}#{(0..3).map { |j| state[j][i] }.join('#')}#{suffix}"
       end,
       "  #########",
      ].flatten.join("\n")
    end

    def solve
      too_big = 999_999_999
      states = Hash.new(too_big)
      nodes = PriorityQueue.new
      nodes << [0, state]
      count = 0
      solved = ROOM.map { |r| Array.new(room_size, HOME[r]) }
      solved << Array.new(7, EMPTY_SPACE)

      while node = nodes.pop
        cost, state = node
        next unless states[state] == too_big

        states[state] = cost
        return cost if state == solved

        @state = state
        next_states.each do |move_cost, state|
          next unless states[state] == too_big
          nodes << [cost + move_cost, state]
        end
      end
    end
  end

  def self.part1(input)
    board = Board.new input
    board.solve
  end

  # As you prepare to give the amphipod your solution, you notice that the
  # diagram they handed you was actually folded up. As you unfold it, you
  # discover an extra part of the diagram.
  #
  # Between the first and second lines of text that contain amphipod starting
  # positions, insert the following lines:
  #
  #   #D#C#B#A#
  #   #D#B#A#C#
  #
  # So, the above example now becomes:
  #
  # #############
  # #...........#
  # ###B#C#B#D###
  #   #D#C#B#A#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # The amphipods still want to be organized into rooms similar to before:
  #
  # #############
  # #...........#
  # ###A#B#C#D###
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # In this updated example, the least energy required to organize these
  # amphipods is 44169:
  #
  # #############
  # #...........#
  # ###B#C#B#D###
  #   #D#C#B#A#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #..........D#
  # ###B#C#B#.###
  #   #D#C#B#A#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #A.........D#
  # ###B#C#B#.###
  #   #D#C#B#.#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #A........BD#
  # ###B#C#.#.###
  #   #D#C#B#.#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #A......B.BD#
  # ###B#C#.#.###
  #   #D#C#.#.#
  #   #D#B#A#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #AA.....B.BD#
  # ###B#C#.#.###
  #   #D#C#.#.#
  #   #D#B#.#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #AA.....B.BD#
  # ###B#.#.#.###
  #   #D#C#.#.#
  #   #D#B#C#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #AA.....B.BD#
  # ###B#.#.#.###
  #   #D#.#C#.#
  #   #D#B#C#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #AA...B.B.BD#
  # ###B#.#.#.###
  #   #D#.#C#.#
  #   #D#.#C#C#
  #   #A#D#C#A#
  #   #########
  #
  # #############
  # #AA.D.B.B.BD#
  # ###B#.#.#.###
  #   #D#.#C#.#
  #   #D#.#C#C#
  #   #A#.#C#A#
  #   #########
  #
  # #############
  # #AA.D...B.BD#
  # ###B#.#.#.###
  #   #D#.#C#.#
  #   #D#.#C#C#
  #   #A#B#C#A#
  #   #########
  #
  # #############
  # #AA.D.....BD#
  # ###B#.#.#.###
  #   #D#.#C#.#
  #   #D#B#C#C#
  #   #A#B#C#A#
  #   #########
  #
  # #############
  # #AA.D......D#
  # ###B#.#.#.###
  #   #D#B#C#.#
  #   #D#B#C#C#
  #   #A#B#C#A#
  #   #########
  #
  # #############
  # #AA.D......D#
  # ###B#.#C#.###
  #   #D#B#C#.#
  #   #D#B#C#.#
  #   #A#B#C#A#
  #   #########
  #
  # #############
  # #AA.D.....AD#
  # ###B#.#C#.###
  #   #D#B#C#.#
  #   #D#B#C#.#
  #   #A#B#C#.#
  #   #########
  #
  # #############
  # #AA.......AD#
  # ###B#.#C#.###
  #   #D#B#C#.#
  #   #D#B#C#.#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #AA.......AD#
  # ###.#B#C#.###
  #   #D#B#C#.#
  #   #D#B#C#.#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #AA.......AD#
  # ###.#B#C#.###
  #   #.#B#C#.#
  #   #D#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #AA.D.....AD#
  # ###.#B#C#.###
  #   #.#B#C#.#
  #   #.#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #A..D.....AD#
  # ###.#B#C#.###
  #   #.#B#C#.#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #...D.....AD#
  # ###.#B#C#.###
  #   #A#B#C#.#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #.........AD#
  # ###.#B#C#.###
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #..........D#
  # ###A#B#C#.###
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # #############
  # #...........#
  # ###A#B#C#D###
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #A#B#C#D#
  #   #########
  #
  # Using the initial configuration from the full diagram, what is the least
  # energy required to organize the amphipods?s

  def self.part2(input)
    input.insert(3, *['  #D#C#B#A#', '  #D#B#A#C#'])
    board = Board.new input
    board.solve
  end

  class PriorityQueue
    attr_reader :data

    def initialize
      @data = []
    end

    def <<(v)
      @data << v
      swim(size - 1)
      self
    end

    def pop
      remove_at(0)
    end

    def size
      @data.size
    end

    def empty?
      @data.empty?
    end

    def swap(i, j)
      @data[i], @data[j] = @data[j], @data[i]
    end

    def less(i, j)
      @data[i].first < @data[j].first
    end

    def swim(i)
      parent = (i - 1) / 2
      while i > 0 && less(i, parent)
        swap(i, parent)
        i = parent
        parent = (i - 1)/ 2
      end
    end

    def sink(i)
      while (j = min_child(i)) >= 1
        swap(i, j)
        i = j
      end
    end

    def min_child(i)
      left = 2 * i + 1
      right = left + 1
      return -1 if left >= size
      return right if right < size && less(right, left) && less(right, i)

      less(left, i) ? left : -1
    end

    def remove_at(k)
      return if empty?

      last_index = size - 1
      swap(k, last_index)
      value = @data.pop
      return value if k == last_index

      elem = @data[k]
      sink(k)
      swim(k) if @data[k].eql? elem

      value
    end
  end
end
