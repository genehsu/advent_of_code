require 'day11'

RSpec.describe Day11 do
  let(:part1_answer) { "hxbxxyzz" }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { "abcdefgh" }
      it { is_expected.to eq "abcdffaa" }
    end

    context "problem" do
      let(:input) { AocInput.read(11).first }
      let(:answer) { part1_answer }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { part1_answer }
      let(:answer) { "hxcaabcc" }
      it { is_expected.to eq answer }
    end
  end
end
