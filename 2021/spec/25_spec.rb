require 'day25'

RSpec.describe Day25 do
  let(:example) do
    <<~EODATA.split(/\n/)
      v...>>.vv>
      .vv>>.vv..
      >>.>v>...v
      >>v>>.>.v.
      v>v.vv.v..
      >.>>..v...
      .vv..>.>v.
      v.v..>>v.v
      ....v..v.>
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 58 }
    end

    context "problem" do
      let(:input) { AocInput.read(25) }
      let(:answer) { 492 }
      it { is_expected.to eq answer }
    end
  end
end
