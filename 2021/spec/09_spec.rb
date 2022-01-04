require 'day09'

RSpec.describe Day09 do
  let(:example) do
    <<~EODATA.split(/\n/)
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 15 }
    end

    context "problem" do
      let(:input) { AocInput.read(9) }
      let(:answer) { 491 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 1134 }
    end

    context "problem" do
      let(:input) { AocInput.read(9) }
      let(:answer) { 1075536 }
      it { is_expected.to eq answer }
    end
  end
end
