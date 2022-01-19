require 'day03'

RSpec.describe Day03 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { AocInput.read(3) }
      let(:answer) { 1032 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(3) }
      let(:answer) { 1838 }
      it { is_expected.to eq answer }
    end
  end
end
