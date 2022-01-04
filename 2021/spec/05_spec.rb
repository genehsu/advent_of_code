require 'day05'

RSpec.describe Day05 do
  let(:example) do
    <<~EODATA.split(/\n/)
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 5 }
    end

    context "problem" do
      let(:input) { AocInput.read(5) }
      let(:answer) { 5147 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 12 }
    end

    context "problem" do
      let(:input) { AocInput.read(5) }
      let(:answer) { 16925 }
      it { is_expected.to eq answer }
    end
  end
end
