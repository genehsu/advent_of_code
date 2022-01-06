# frozen_string_literal: true
# https://adventofcode.com/2021/day/23

require_relative '../../lib/priority_queue'

class Day23

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

  def self.part2(input)
    input.insert(3, *['  #D#C#B#A#', '  #D#B#A#C#'])
    board = Board.new input
    board.solve
  end
end
