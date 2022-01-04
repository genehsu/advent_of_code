require 'day03'

RSpec.describe Day03 do
  let(:example) do
    <<~EODATA.split(/\n/)
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    EODATA
  end

  context "Part 1" do
    subject  { gamma_rate * epsilon_rate }
    let(:gamma_rate) { decode_result[0] }
    let(:epsilon_rate) { decode_result[1] }
    let(:decode_result) { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 198 }
    end

    context "problem" do
      let(:input) { AocInput.read(3) }
      let(:answer) { 3374136 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { o2 * co2 }
    let(:o2) { decode_result[0] }
    let(:co2) { decode_result[1] }
    let(:decode_result) { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 230 }
    end

    context "problem" do
      let(:input) { AocInput.read(3) }
      let(:answer) { 4432698 }
      it { is_expected.to eq answer }
    end
  end
end
