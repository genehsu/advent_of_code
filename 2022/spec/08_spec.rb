require 'day08'

RSpec.describe Day08 do
  let(:input) { AocInput.read(8) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 21 }
    end

    context "problem" do
      let(:answer) { 1801 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 8 }
    end

    context "problem" do
      let(:answer) { 209880 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      30373
      25512
      65332
      33549
      35390
    EODATA
  end
end
