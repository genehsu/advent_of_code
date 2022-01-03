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
      let(:input) { AocInput.read(9) }
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
      let(:input) { AocInput.read(9) }
      let(:answer) { 898 }
      it { is_expected.to eq answer }
    end
  end
end
