require 'day02'

RSpec.describe Day02 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          ULL
          RRDDD
          LURDL
          UUUUD
        EODATA
      end
      it { is_expected.to eq "1985" }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { "82958" }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          ULL
          RRDDD
          LURDL
          UUUUD
        EODATA
      end
      it { is_expected.to eq "5DB3" }
    end

    context "problem" do
      let(:input) { AocInput.read(2) }
      let(:answer) { "B3DB8" }
      it { is_expected.to eq answer }
    end
  end
end
