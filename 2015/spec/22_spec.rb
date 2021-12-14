require 'day22'

RSpec.describe Day22 do
  let(:player) { { hp: 50, mana: 500 } }

  context "Part 1" do
    subject { described_class.part1 player, input }

    context "problem" do
      let(:input) { day22 }
      let(:answer) { 1269 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 player, input }

    context "problem" do
      let(:input) { day22 }
      let(:answer) { 1309 }
      it { is_expected.to eq answer }
    end
  end
end

def day22
  { hp: 58, damage: 9 }
end
