require 'day15'

RSpec.describe Day15 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
      Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 62842880 }
    end

    context "problem" do
      let(:input) { day15 }
      let(:answer) { 21367368 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 57600000 }
    end

    context "problem" do
      let(:input) { day15 }
      let(:answer) { 1766400 }
      it { is_expected.to eq answer }
    end
  end
end

def day15
  <<~'EODATA'.split(/\n/)
    Sprinkles: capacity 2, durability 0, flavor -2, texture 0, calories 3
    Butterscotch: capacity 0, durability 5, flavor -3, texture 0, calories 3
    Chocolate: capacity 0, durability 0, flavor 5, texture -1, calories 8
    Candy: capacity 0, durability -1, flavor 0, texture 5, calories 8
  EODATA
end
