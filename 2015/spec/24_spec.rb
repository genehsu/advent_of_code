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
      let(:input) { AocInput.read(24).map(&:to_i) }
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
      let(:input) { AocInput.read(24).map(&:to_i) }
      let(:answer) { 72050269 }
      it { is_expected.to eq answer }
    end
  end
end
