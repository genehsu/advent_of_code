require 'day09'

RSpec.describe Day09 do
  let(:input) { AocInput.read(9) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 13 }
    end

    context "problem" do
      let(:answer) { 6311 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 1 }
    end

    context "example2" do
      let(:input) { example2 }
      it { is_expected.to eq 36 }
    end

    context "problem" do
      let(:answer) { 2482 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    EODATA
  end

  def example2
    <<~EODATA.split("\n")
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20
    EODATA
  end
end

