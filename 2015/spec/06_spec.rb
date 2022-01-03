require 'day06'

RSpec.describe Day06 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      [[['turn on 0,0 through 999,999',
         'toggle 0,0 through 999,0',
         'turn off 499,499 through 500,500',
        ], 998_996],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(06) }
      let(:answer) { 377891 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      [[['turn on 0,0 through 999,999',
         'toggle 0,0 through 999,0',
         'turn off 499,499 through 500,500',
        ], 1_001_996],
      ].each_with_index do |(example, expected), i|
        context "example #{i}" do
          let(:input) { example }
          it { is_expected.to eq expected }
        end
      end
    end

    context "problem" do
      let(:input) { AocInput.read(06) }
      let(:answer) { 14110788 }
      it { is_expected.to eq answer }
    end
  end
end
