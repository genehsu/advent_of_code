require 'day05'

RSpec.describe Day05 do
  let(:input) { AocInput.read(5) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 'CMZ' }
    end

    context "problem" do
      let(:answer) { 'VRWBSFZWM' }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 'MCD' }
    end

    context "problem" do
      let(:answer) { 'RBTWJWMCF' }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
          [D]    
      [N] [C]    
      [Z] [M] [P]
       1   2   3 

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
    EODATA
  end
end
