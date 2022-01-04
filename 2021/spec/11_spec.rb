require 'day11'

RSpec.describe Day11 do
  let (:example) do
    <<~EODATA.split(/\n/)
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 1656}
    end

    context "problem" do
      let(:input) { AocInput.read(11) }
      let(:answer) { 1669 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 195 }
    end

    context "problem" do
      let(:input) { AocInput.read(11) }
      let(:answer) { 351 }
      it { is_expected.to eq answer }
    end
  end
end
