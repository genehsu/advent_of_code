require 'day15'

RSpec.describe Day15 do
  let (:example) do
    <<~EODATA.split(/\n/)
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 40 }
    end

    context "problem" do
      let(:input) { AocInput.read(15) }
      let(:answer) { 741 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 315 }
    end

    context "problem" do
      let(:input) { AocInput.read(15) }
      let(:answer) { 2976 }
      it { is_expected.to eq answer }
    end
  end
end
