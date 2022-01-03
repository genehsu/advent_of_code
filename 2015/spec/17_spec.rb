require 'day17'

RSpec.describe Day17 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      20
      15
      10
      5
      5
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input, quantity }

    context "example" do
      let(:input) { example }
      let(:quantity) { 25 }
      it { is_expected.to eq 4 }
    end

    context "problem" do
      let(:input) { AocInput.read(17) }
      let(:quantity) { 150 }
      let(:answer) { 654 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, quantity }

    context "example" do
      let(:input) { example }
      let(:quantity) { 25 }
      it { is_expected.to eq 3 }
    end

    context "problem" do
      let(:input) { AocInput.read(17) }
      let(:quantity) { 150 }
      let(:answer) { 57 }
      it { is_expected.to eq answer }
    end
  end
end
