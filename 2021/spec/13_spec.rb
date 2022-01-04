require 'day13'

RSpec.describe Day13 do
  let (:example) do
    <<~EODATA.split(/\n/)
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 17}
    end

    context "problem" do
      let(:input) { AocInput.read(13) }
      let(:answer) { 618 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 16}
    end

    context "problem" do
      let(:input) { AocInput.read(13) }
      let(:answer) { 98 }
      it { is_expected.to eq answer }
    end
  end
end
