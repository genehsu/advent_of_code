require 'day09'

RSpec.describe Day09 do
  let(:example) do
    <<~'EODATA'.split(/\n/)
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 605 }
    end

    context "problem" do
      let(:input) { day09 }
      let(:answer) { 251 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 982 }
    end

    context "problem" do
      let(:input) { day09 }
      let(:answer) { 898 }
      it { is_expected.to eq answer }
    end
  end
end

def day09
  <<~'EODATA'.split(/\n/)
    Tristram to AlphaCentauri = 34
    Tristram to Snowdin = 100
    Tristram to Tambi = 63
    Tristram to Faerun = 108
    Tristram to Norrath = 111
    Tristram to Straylight = 89
    Tristram to Arbre = 132
    AlphaCentauri to Snowdin = 4
    AlphaCentauri to Tambi = 79
    AlphaCentauri to Faerun = 44
    AlphaCentauri to Norrath = 147
    AlphaCentauri to Straylight = 133
    AlphaCentauri to Arbre = 74
    Snowdin to Tambi = 105
    Snowdin to Faerun = 95
    Snowdin to Norrath = 48
    Snowdin to Straylight = 88
    Snowdin to Arbre = 7
    Tambi to Faerun = 68
    Tambi to Norrath = 134
    Tambi to Straylight = 107
    Tambi to Arbre = 40
    Faerun to Norrath = 11
    Faerun to Straylight = 66
    Faerun to Arbre = 144
    Norrath to Straylight = 115
    Norrath to Arbre = 135
    Straylight to Arbre = 127
  EODATA
end
