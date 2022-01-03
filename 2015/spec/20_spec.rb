require 'day20'

RSpec.describe Day20 do
  context "count_presents" do
    subject { described_class.count_presents n }

    context "example" do
      let(:n) { 4 }
      it { is_expected.to eq 70 }
    end
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { AocInput.read(20).first.to_i }
      let(:answer) { 776160 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(20).first.to_i }
      let(:answer) { 786240 }
      it { is_expected.to eq answer }
    end
  end
end
