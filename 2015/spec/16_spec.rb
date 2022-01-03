require 'day16'

RSpec.describe Day16 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { AocInput.read(16) }
      let(:answer) { 213 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "problem" do
      let(:input) { AocInput.read(16) }
      let(:answer) { 323 }
      it { is_expected.to eq answer }
    end
  end
end
