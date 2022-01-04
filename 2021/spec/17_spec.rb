require 'day17'

RSpec.describe Day17 do
  let (:example) { 'target area: x=20..30, y=-10..-5' }

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 45 }
    end

    context "problem" do
      let(:input) { AocInput.read_line(17) }
      let(:answer) { 3160 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 112 }
    end

    context "problem" do
      let(:input) { AocInput.read_line(17) }
      let(:answer) { 1928 }
      it { is_expected.to eq answer }
    end
  end
end
