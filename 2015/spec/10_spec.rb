require 'day10'

RSpec.describe Day10 do
  describe ".look_and_say" do
    subject { described_class.look_and_say(input) }

    [[1, 11],
     [11, 21],
     [21, 1211],
     [1211, 111221],
     [111221, 312211],
    ].each_with_index do |(input, expected), i|
      context  "example #{i}" do
        let(:input) { input.to_s }
        it { is_expected.to eq expected.to_s }
      end
    end
  end
  let(:example) do
    <<~'EODATA'.split(/\n/)
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { day10 }
      let(:answer) { 252594 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { day10 }
      let(:answer) { 3579328 }
      it { is_expected.to eq answer }
    end
  end
end

def day10
  "1113222113"
end
