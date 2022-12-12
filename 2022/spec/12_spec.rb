require 'day12'

RSpec.describe Day12 do
  let(:input) { AocInput.read(12) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 31 }
    end

    context "problem" do
      let(:answer) { 484 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 29 }
    end

    context "problem" do
      let(:answer) { 478 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
    EODATA
  end
end
