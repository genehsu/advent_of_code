require 'day01'

RSpec.describe Day01 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [['(())', 0],
       ['()()', 0],
       ['(((', 3],
       ['(()(()(', 3],
       ['))(((((', 3],
       ['())', -1],
       ['))(', -1],
       [')))', -3],
       [')())())', -3],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(01).first }
      let(:answer) { 232 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [[')', 1],
       ['()())', 5],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(01).first }
      let(:answer) { 1783 }
      it { is_expected.to eq answer }
    end
  end
end
