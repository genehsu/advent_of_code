require 'day03'

RSpec.describe Day03 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [['>', 2],
       ['^>v<', 4],
       ['^v^v^v^v^v', 2],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(03).first }
      let(:answer) { 2592 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [['^v', 3],
       ['^>v<', 3],
       ['^v^v^v^v^v', 11],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(03).first }
      let(:answer) { 2360 }
      it { is_expected.to eq answer }
    end
  end
end
