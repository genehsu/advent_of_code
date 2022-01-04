require 'day14'

RSpec.describe Day14 do
  let (:example) do
    <<~EODATA.split(/\n/)
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 1588 }
    end

    context "problem" do
      let(:input) { AocInput.read(14) }
      let(:answer) { 2027 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 2188189693529 }
    end

    context "problem" do
      let(:input) { AocInput.read(14) }
      let(:answer) { 2265039461737 }
      it { is_expected.to eq answer }
    end
  end
end
