require 'day07'

RSpec.describe Day07 do
  let(:input) { AocInput.read(7) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 95437 }
    end

    context "problem" do
      let(:answer) { 1845346 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 24933642 }
    end

    context "problem" do
      let(:answer) { 3636703 }
      it { is_expected.to eq answer }
    end
  end

  def example
    <<~EODATA.split("\n")
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
    EODATA
  end
end
