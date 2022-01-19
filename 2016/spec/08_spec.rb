require 'day08'

RSpec.describe Day08 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          rect 3x2
          rotate column x=1 by 1
          rotate row y=0 by 4
          rotate column x=1 by 1
        EODATA
      end
      it { is_expected.to eq 6 }
    end

    context "problem" do
      let(:input) { AocInput.read(8) }
      let(:answer) { 128 }
      it { is_expected.to eq answer }
    end
  end
end
