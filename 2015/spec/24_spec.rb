require 'day24'

RSpec.describe Day24 do
  let(:example) do
    [1, 2, 3, 4, 5, 7, 8, 9, 10, 11]
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 99 }
    end

    context "problem" do
      let(:input) { day24 }
      let(:answer) { 10439961859 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 44 }
    end

    context "problem" do
      let(:input) { day24 }
      let(:answer) { 72050269 }
      it { is_expected.to eq answer }
    end
  end
end

def day24
  [1, 3, 5, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113]
end
