require 'day10'

RSpec.describe Day10 do
  let(:example) do
    <<~EODATA.split(/\n/)
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 26397 }
    end

    context "problem" do
      let(:input) { AocInput.read(10) }
      let(:answer) { 323691 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 288957 }
    end

    context "problem" do
      let(:input) { AocInput.read(10) }
      let(:answer) { 2858785164 }
      it { is_expected.to eq answer }
    end
  end
end
