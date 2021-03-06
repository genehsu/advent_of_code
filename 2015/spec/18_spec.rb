require 'day18'

RSpec.describe Day18 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      .#.#.#
      ...##.
      #....#
      ..#...
      #.#..#
      ####..
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input, steps }

    context "example" do
      let(:input) { example }
      let(:steps) { 5 }
      it { is_expected.to eq 4 }
    end

    context "problem" do
      let(:input) { AocInput.read(18) }
      let(:steps) { 100 }
      let(:answer) { 768 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, steps }

    context "example" do
      let(:input) { example }
      let(:steps) { 5 }
      it { is_expected.to eq 17 }
    end

    context "problem" do
      let(:input) { AocInput.read(18) }
      let(:steps) { 100 }
      let(:answer) { 781 }
      it { is_expected.to eq answer }
    end
  end
end
