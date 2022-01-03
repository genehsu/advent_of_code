require 'day07'

RSpec.describe Day07 do
  context "Part 1" do
    subject { described_class.part1 input, label }

    context "example" do
      let(:example) do
        <<~EODATA.split(/\n/)
          123 -> x
          456 -> y
          x AND y -> d
          x OR y -> e
          x LSHIFT 2 -> f
          y RSHIFT 2 -> g
          NOT x -> h
          NOT y -> i
        EODATA
      end
      let(:input) { example }
      let(:label) { 'd' }

      it { is_expected.to eq 72 }
    end

    context "problem" do
      let(:input) { AocInput.read(07) }
      let(:label) { 'a' }
      let(:answer) { 16076 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, label }

    context "problem" do
      let(:input) { AocInput.read(07) }
      let(:label) { 'a' }
      let(:answer) { 2797 }
      it { is_expected.to eq answer }
    end
  end
end
