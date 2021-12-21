require 'day21'

RSpec.describe Day21 do
  let(:example) do
    [4, 8]
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 739785 }
    end

    context "problem" do
      let(:input) { day21 }
      let(:answer) { 888735 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 444356092776315 }
    end

    context "problem" do
      let(:input) { day21 }
      let(:answer) { 647608359455719 }
      it { is_expected.to eq answer }
    end
  end
end

def day21
  [4, 6]
end
