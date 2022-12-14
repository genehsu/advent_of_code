require 'day14'

RSpec.describe Day14 do
  let(:input) { AocInput.read(14) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 24 }
    end

    context "problem" do
      let(:answer) { 655 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 93 }
    end

    context "problem" do
      let(:answer) { 26484 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9
    EODATA
  end
end
