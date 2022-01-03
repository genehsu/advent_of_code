require 'day12'

RSpec.describe Day12 do
  context "Part 1" do
    subject { described_class.part1 input }

    [['[1,2,3]', 6],
     ['{"a":2,"b":4}', 6],
     ['[[[3]]]', 3],
     ['{"a":{"b":4},"c":-1}', 3],
     ['{"a":[-1,1]}', 0],
     ['[-1,{"a":1}]', 0],
     ['[]', 0],
     ['{}', 0],
    ].each_with_index do |(input, expected), i|
      context "example #{i}" do
        let(:input) { input }
        it { is_expected.to eq expected }
      end
    end

    context "problem" do
      let(:input) { AocInput.read(12).first }
      let(:answer) { 111754 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    [['[1,2,3]', 6],
     ['[1,{"c":"red","b":2},3]', 4],
     ['{"d":"red","e":[1,2,3,4],"f":5}', 0],
     ['[1,"red",5]', 6],
    ].each_with_index do |(input, expected), i|
      context "example #{i}" do
        let(:input) { input }
        it { is_expected.to eq expected }
      end
    end

    context "problem" do
      let(:input) { AocInput.read(12).first }
      let(:answer) { 65402 }
      it { is_expected.to eq answer }
    end
  end
end
