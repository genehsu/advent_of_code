require 'day04'

RSpec.describe Day04 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [['abcdef', 609043],
       ['pqrstuv', 1048970],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(04).first }
      let(:answer) { 346386 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(04).first }
      let(:answer) { 9958218 }
      it { is_expected.to eq answer }
    end
  end
end
