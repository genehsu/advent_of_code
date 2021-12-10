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
      let(:input) { day14 }
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
      let(:input) { day14 }
      let(:elapsed_time) { 2503 }
      let(:answer) { 1059 }
      it { is_expected.to eq answer }
    end
  end
end

def day14
  <<~'EODATA'.split(/\n/)
    Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.
    Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.
    Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.
    Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.
    Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.
    Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.
    Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.
    Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.
    Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.
  EODATA
end
