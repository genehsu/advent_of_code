require 'day03'

RSpec.describe Day03 do
  let(:input) { AocInput.read(3) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 157 }
    end

    context "problem" do
      let(:answer) { 7701 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 70 }
    end

    context "problem" do
      let(:answer) { 2644 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
    EODATA
  end
end
