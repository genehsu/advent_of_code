require 'day08'

RSpec.describe Day08 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      ""
      "abc"
      "aaa\"aaa"
      "\x27"
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 12 }
    end

    context "problem" do
      let(:input) { AocInput.read(8) }
      let(:answer) { 1333 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 19 }
    end

    context "problem" do
      let(:input) { AocInput.read(8) }
      let(:answer) { 2046 }
      it { is_expected.to eq answer }
    end
  end
end
