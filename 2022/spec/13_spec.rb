require 'day13'

RSpec.describe Day13 do
  let(:input) { AocInput.read(13) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 13 }
    end

    context "problem" do
      let(:answer) { 6076 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 140 }
    end

    context "problem" do
      let(:answer) { 24805 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    EODATA
  end
end
