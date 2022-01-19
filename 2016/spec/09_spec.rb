require 'day09'

RSpec.describe Day09 do
  context "Part 1" do
    subject { described_class.part1 input }

    [['ADVENT', 6],
     ['A(1x5)BC', 7],
     ['A(2x2)BCD(2x2)EFG', 11],
     ['(6x1)(1x3)A', 6],
     ['X(8x2)(3x3)ABCY', 18],
    ].each_with_index do |(example,expected), i|
      context "example #{i}" do
        let(:input) { example }
        it { is_expected.to eq expected }
      end
    end

    context "problem" do
      let(:input) { AocInput.read_line(9) }
      let(:answer) { 102239 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    [['(3x3)XYZ', 9],
     ['X(8x2)(3x3)ABCY', 20],
     ['(27x12)(20x12)(13x14)(7x10)(1x12)A', 241920],
     ['(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN', 445],
    ].each_with_index do |(example,expected), i|
      context "example #{i}" do
        let(:input) { example }
        it { is_expected.to eq expected }
      end
    end

    context "problem" do
      let(:input) { AocInput.read_line(9) }
      let(:answer) { 10780403063 }
      it { is_expected.to eq answer }
    end
  end
end
