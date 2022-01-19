require 'day05'

RSpec.describe Day05 do
  context "Part 1" do
    subject { described_class.part1 input }

    xcontext "example" do
      let(:input) { "abc" }
      it { is_expected.to eq "18f47a30" }
    end

    context "problem" do
      let(:input) { AocInput.read_line(5) }
      let(:answer) { "f97c354d" }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    xcontext "example" do
      let(:input) { "abc" }
      it { is_expected.to eq "05ace8e3" }
    end

    context "problem" do
      let(:input) { AocInput.read_line(5) }
      let(:answer) { "863dde27" }
      it { is_expected.to eq answer }
    end
  end
end
