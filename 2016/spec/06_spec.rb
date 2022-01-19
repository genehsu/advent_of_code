require 'day06'

RSpec.describe Day06 do
  let(:example) do
    <<~EODATA.split(/\n/)
      eedadn
      drvtee
      eandsr
      raavrd
      atevrs
      tsrnev
      sdttsa
      rasrtv
      nssdts
      ntnada
      svetve
      tesnvt
      vntsnd
      vrdear
      dvrsen
      enarar
    EODATA
  end

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq "easter" }
    end

    context "problem" do
      let(:input) { AocInput.read(6) }
      let(:answer) { "qoclwvah" }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq "advent" }
    end

    context "problem" do
      let(:input) { AocInput.read(6) }
      let(:answer) { "ryrgviuv" }
      it { is_expected.to eq answer }
    end
  end
end
