require 'day18'

RSpec.describe Day18 do
  let(:snailfish) { described_class.new data }

  context "reduce" do
    subject { snailfish.data }

    before { snailfish.reduce }

    [[ '[[[[[9,8],1],2],3],4]',                   [[[[0,9],2],3],4]                 ],
     [ '[7,[6,[5,[4,[3,2]]]]]',                   [7,[6,[5,[7,0]]]]                 ],
     [ '[[6,[5,[4,[3,2]]]],1]',                   [[6,[5,[7,0]]],3]                 ],
     [ '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]',   [[3,[2,[8,0]]],[9,[5,[7,0]]]]     ],
     [ '[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]',   [[[[0,7],4],[[7,8],[6,0]]],[8,1]] ],
    ].each_with_index do |(input, expected), i|
      context "example #{i}" do
        let(:data) { input }
        it { is_expected.to eq expected }
      end
    end

    context "complex" do
      let(:data) do
        '[[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]]'
      end
      let(:expected) { [[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]] }

      it { is_expected.to eq expected }
    end
  end

  context "sums" do
    subject { snailfish.data }

    before { list.each { |e| snailfish.add e } }

    [[ '[1,1]', ['[2,2]','[3,3]','[4,4]'],                  [[[[1,1],[2,2]],[3,3]],[4,4]] ],
     [ '[1,1]', ['[2,2]','[3,3]','[4,4]','[5,5]'],          [[[[3,0],[5,3]],[4,4]],[5,5]] ],
     [ '[1,1]', ['[2,2]','[3,3]','[4,4]','[5,5]','[6,6]'],  [[[[5,0],[7,4]],[5,5]],[6,6]] ],
    ].each_with_index do |(data, list, expected), i|
      context "example #{i}" do
        let(:data) { data }
        let(:list) { list }
        it { is_expected.to eq expected }
      end
    end
  end

  context "big sum" do
    subject { snailfish.data }

    let(:data) { '[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]' }
    let(:example) do
      [
        # [[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]],
        '[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]',
        '[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]',
        '[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]',
        '[7,[5,[[3,8],[1,4]]]]',
        '[[2,[2,2]],[8,[8,1]]]',
        '[2,9]',
        '[1,[[[9,3],9],[[9,0],[0,7]]]]',
        '[[[5,[7,4]],7],1]',
        '[[[[4,2],2],6],[8,7]]',
      ]
    end
    let(:input) { example }
    let(:expected) { [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]] }

    before { input.each { |fish| snailfish.add fish } }

    it { is_expected.to eq expected }
  end

  context "magnitude" do
    subject { snailfish.magnitude }

    [[ [[1,2],[[3,4],5]],                                      143 ],
     [ [[[[0,7],4],[[7,8],[6,0]]],[8,1]],                     1384 ],
     [ [[[[1,1],[2,2]],[3,3]],[4,4]],                          445 ],
     [ [[[[3,0],[5,3]],[4,4]],[5,5]],                          791 ],
     [ [[[[5,0],[7,4]],[5,5]],[6,6]],                         1137 ],
     [ [[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]], 3488 ],
    ].each_with_index do |(data, expected), i|
      context "example #{i}" do
        let(:data) { data }
        it { is_expected.to eq expected }
      end
    end
  end

  let(:example) do
    [
      [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]],
      [[[5,[2,8]],4],[5,[[9,9],0]]],
      [6,[[[6,2],[5,6]],[[7,6],[4,7]]]],
      [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]],
      [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]],
      [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]],
      [[[[5,4],[7,7]],8],[[8,3],8]],
      [[9,3],[[9,9],[6,[4,9]]]],
      [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]],
      [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]],
    ]
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 4140 }
    end

    context "problem" do
      let(:input) { AocInput.read(18) }
      let(:answer) { 4176 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 3993 }
    end

    context "problem" do
      let(:input) { AocInput.read(18) }
      let(:answer) { 4633 }
      it { is_expected.to eq answer }
    end
  end
end
