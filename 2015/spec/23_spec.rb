require 'day23'

RSpec.describe Day23 do
  let(:example) do
    <<~EODATA.split(/\n/)
      inc a
      jio a, +2
      tpl a
      inc a
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input, register }

    context "example" do
      let(:input) { example }
      let(:register) { "a" }
      it { is_expected.to eq 2 }
    end

    context "problem" do
      let(:input) { AocInput.read(23) }
      let(:register) { "b" }
      let(:answer) { 255 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, register }

    context "problem" do
      let(:input) { AocInput.read(23) }
      let(:register) { "b" }
      let(:answer) { 334 }
      it { is_expected.to eq answer }
    end
  end
end
