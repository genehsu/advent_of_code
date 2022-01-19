require 'day10'

RSpec.describe Day10 do
  context "Part 1" do
    subject { described_class.part1 input, comparison }

    let(:example) do
      <<~EODATA.split("\n")
        value 5 goes to bot 2
        bot 2 gives low to bot 1 and high to bot 0
        value 3 goes to bot 1
        bot 1 gives low to output 1 and high to bot 0
        bot 0 gives low to output 2 and high to output 0
        value 2 goes to bot 2
      EODATA
    end

    context "example" do
      let(:input) { example }
      let(:comparison) { [2, 5] }
      it { is_expected.to eq 2 }
    end

    context "problem" do
      let(:input) { AocInput.read(10) }
      let(:comparison) { [17, 61] }
      let(:answer) { 141 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(10) }
      let(:answer) { 1209 }
      it { is_expected.to eq answer }
    end
  end
end
