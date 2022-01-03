require 'day05'

RSpec.describe Day05 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [[%w[ ugknbfddgicrmopn aaa
            jchzalrnumimnmhp haegwjzuvuyypxyu dvszwmarrgswjxmb ], 2]
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(05) }
      let(:answer) { 238 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [[%w[ qjhvhtzxzqqjkmpb xxyxx
            uurcxstgmygtbstg ieodomkazucvgmuy ], 2],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(05) }
      let(:answer) { 69 }
      it { is_expected.to eq answer }
    end
  end
end
