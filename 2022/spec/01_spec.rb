require 'day01'

RSpec.describe Day01 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 24000 }
    end

    context "problem" do
      let(:input) { AocInput.read(1) }
      let(:answer) { 71780 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 45000 }
    end

    context "problem" do
      let(:input) { AocInput.read(1) }
      let(:answer) { 212489 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      1000
      2000
      3000

      4000

      5000
      6000

      7000
      8000
      9000

      10000
    EODATA
  end
end
