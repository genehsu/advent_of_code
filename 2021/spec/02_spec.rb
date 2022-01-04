require 'day02'

RSpec.describe Day02 do
  subject  { horizontal * depth }
  let(:horizontal) { pilot_result[0] }
  let(:depth) { pilot_result[1] }
  let(:example) do
    <<~EODATA.split(/\n/)
      forward 5
      down 5
      forward 8
      up 3
      down 8
      forward 2
    EODATA
  end

  context "Part 1" do
    let(:pilot_result) { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 150 }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { 1507611  }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    let(:pilot_result) { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 900 }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { 1880593125 }
      it { is_expected.to eq answer }
    end
  end
end
