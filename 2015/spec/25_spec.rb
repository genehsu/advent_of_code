require 'day25'

RSpec.describe Day25 do
  context "Part 1" do
    subject { described_class.part1 row, column }

    context "example" do
      let(:row) { 5 }
      let(:column) { 4 }
      it { is_expected.to eq 6899651 }
    end

    context "problem" do
      let(:row) { 3010 }
      let(:column) { 3019 }
      let(:answer) { 8997277 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 row, column }
  end
end
