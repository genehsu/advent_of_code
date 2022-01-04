require 'day01'

RSpec.describe Day01 do
  let(:example) { [199, 200, 208, 210, 200, 207, 240, 269, 260, 263] }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 7 }
    end

    context "problem" do
      let(:input) { AocInput.read_ints(1) }
      let(:answer) { 1688 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 5 }
    end

    context "problem" do
      let(:input) { AocInput.read_ints(1) }
      let(:answer) { 1728 }
      it { is_expected.to eq answer }
    end
  end
end
