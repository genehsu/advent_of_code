require 'day11'

RSpec.describe Day11 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { "abcdefgh" }
      it { is_expected.to eq "abcdffaa" }
    end

    context "problem" do
      let(:input) { day11 }
      let(:answer) { "hxbxxyzz" }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part1 input }

    context "problem" do
      let(:input) { "hxbxxyzz" }
      let(:answer) { "hxcaabcc" }
      it { is_expected.to eq answer }
    end
  end
end

def day11
  "hxbxwxba"
end
