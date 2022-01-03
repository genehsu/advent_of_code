require 'day14'

RSpec.describe Day14 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
      Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input, elapsed_time }

    context "example" do
      let(:input) { example }
      let(:elapsed_time) { 1000 }
      it { is_expected.to eq 1120 }
    end

    context "problem" do
      let(:input) { AocInput.read(14) }
      let(:answer) { 2655 }
      let(:elapsed_time) { 2503 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, elapsed_time }

    context "example" do
      let(:input) { example }
      let(:elapsed_time) { 1000 }
      it { is_expected.to eq 689 }
    end

    context "problem" do
      let(:input) { AocInput.read(14) }
      let(:elapsed_time) { 2503 }
      let(:answer) { 1059 }
      it { is_expected.to eq answer }
    end
  end
end
