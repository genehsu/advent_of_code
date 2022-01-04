require 'day07'

RSpec.describe Day07 do
  let(:example) { [16,1,2,0,4,2,7,1,2,14] }

  context "Part 1" do
    subject  { described_class.part1a input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 37}
    end

    context "problem" do
      let(:input) { AocInput.read_int_line(7) }
      let(:answer) { 356922 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2a input }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 168 }
    end

    context "problem" do
      let(:input) { AocInput.read_int_line(7) }
      let(:answer) { 100347031 }
      it { is_expected.to eq answer }
    end
  end
end
