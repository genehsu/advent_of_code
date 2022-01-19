require 'day07'

RSpec.describe Day07 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          abba[mnop]qrst
          abcd[bddb]xyyx
          aaaa[qwer]tyui
          ioxxoj[asdfgh]zxcvbn
        EODATA
      end
      it { is_expected.to eq 2 }
    end

    context "problem" do
      let(:input) { AocInput.read(7) }
      let(:answer) { 115 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          aba[bab]xyz
          xyx[xyx]xyx
          aaa[kek]eke
          zazbz[bzb]cdb
        EODATA
      end
      it { is_expected.to eq 3 }
    end

    context "problem" do
      let(:input) { AocInput.read(7) }
      let(:answer) { 231 }
      it { is_expected.to eq answer }
    end
  end
end
