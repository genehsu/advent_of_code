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

  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { AocInput.read(10).first }
      let(:answer) { 252594 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(10).first }
      let(:answer) { 3579328 }
      it { is_expected.to eq answer }
    end
  end
end
