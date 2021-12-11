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
      let(:input) { day17 }
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
      let(:input) { day17 }
      let(:quantity) { 150 }
      let(:answer) { 57 }
      it { is_expected.to eq answer }
    end
  end
end

def day17
  <<~'EODATA'.split(/\n/)
    50
    44
    11
    49
    42
    46
    18
    32
    26
    40
    21
    7
    18
    43
    10
    47
    36
    24
    22
    40
  EODATA
end
