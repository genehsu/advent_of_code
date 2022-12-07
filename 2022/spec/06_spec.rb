require 'day06'

RSpec.describe Day06 do
  let(:input) { AocInput.read_line(6) }

  context "Part 1" do
    subject { described_class.part1 input }

    context "example1" do
      let(:input) { 'mjqjpqmgbljsphdztnvjfqwrcgsmlb' }
      it { is_expected.to eq 7 }
    end

    context "example2" do
      let(:input) { 'bvwbjplbgvbhsrlpgdmjqwftvncz' }
      it { is_expected.to eq 5 }
    end

    context "example3" do
      let(:input) { 'nppdvjthqldpwncqszvftbrmjlhg' }
      it { is_expected.to eq 6 }
    end

    context "example4" do
      let(:input) { 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' }
      it { is_expected.to eq 10 }
    end

    context "example5" do
      let(:input) { 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' }
      it { is_expected.to eq 11 }
    end

    context "problem" do
      let(:answer) { 1802 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "example1" do
      let(:input) { 'mjqjpqmgbljsphdztnvjfqwrcgsmlb' }
      it { is_expected.to eq 19 }
    end

    context "example2" do
      let(:input) { 'bvwbjplbgvbhsrlpgdmjqwftvncz' }
      it { is_expected.to eq 23 }
    end

    context "example3" do
      let(:input) { 'nppdvjthqldpwncqszvftbrmjlhg' }
      it { is_expected.to eq 23 }
    end

    context "example4" do
      let(:input) { 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg' }
      it { is_expected.to eq 29 }
    end

    context "example5" do
      let(:input) { 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' }
      it { is_expected.to eq 26 }
    end

    context "problem" do
      let(:answer) { 3551 }
      it { is_expected.to eq answer }
    end
  end
end
