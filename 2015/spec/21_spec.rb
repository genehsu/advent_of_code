require 'day21'

RSpec.describe Day21 do
  context "player_win?" do
    subject { game.player_win? }
    let(:game) { described_class.new player, boss }
    let(:player) { described_class.creatureify(hp: 8, damage: 5, armor: 5) }
    let(:boss) { described_class.creatureify(hp: 12, damage: 7, armor: 2) }

    it { is_expected.to be true }
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { AocInput.read(21).join(' ') }
      let(:answer) { 121 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(21).join(' ') }
      let(:answer) { 201 }
      it { is_expected.to eq answer }
    end
  end
end
