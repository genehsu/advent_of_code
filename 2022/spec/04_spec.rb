require 'day04'

RSpec.describe Day04 do
  let(:input) { AocInput.read(4) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 2 }
    end

    context "problem" do
      let(:answer) { 413 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 4 }
    end

    context "problem" do
      let(:answer) { 806 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
    EODATA
  end
end
