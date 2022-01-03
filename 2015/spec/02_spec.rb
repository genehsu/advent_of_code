require 'day02'

RSpec.describe Day02 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [[['2x3x4'], 58],
       [['1x1x10'], 43],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(02) }
      let(:answer) { 1598415 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [[['2x3x4'], 34],
       [['1x1x10'], 14],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(02) }
      let(:answer) { 3812909 }
      it { is_expected.to eq answer }
    end
  end
end
