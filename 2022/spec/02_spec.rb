require 'day02'

RSpec.describe Day02 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 15 }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { 10994 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 12 }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { 12526 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      A Y
      B X
      C Z
    EODATA
  end
end
