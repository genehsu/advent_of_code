require 'day19'

RSpec.describe Day19 do

  context "Part 1" do
    subject { described_class.part1 input, replacements }

    let(:replacements) do
      <<~'EODATA'.split(/\n/)
        H => HO
        H => OH
        O => HH
      EODATA
    end

    context "example 1" do
      let(:input) { "HOH" }
      it { is_expected.to eq 4 }
    end

    context "example 2" do
      let(:input) { "HOHOHO" }
      it { is_expected.to eq 7 }
    end

    context "problem" do
      let(:input) { AocInput.read(19)[-1] }
      let(:replacements) { AocInput.read(19)[0..-3] }
      let(:answer) { 535 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, replacements }

    let(:replacements) do
      <<~'EODATA'.split(/\n/)
        e => H
        e => O
        H => HO
        H => OH
        O => HH
      EODATA
    end

    context "example 1" do
      let(:input) { "HOH" }
      it { is_expected.to eq 3 }
    end

    context "example 2" do
      let(:input) { "HOHOHO" }
      it { is_expected.to eq 6 }
    end

    context "problem" do
      let(:input) { AocInput.read(19)[-1] }
      let(:replacements) { AocInput.read(19)[0..-3] }
      let(:answer) { 212 }
      it { is_expected.to eq answer }
    end
  end
end
