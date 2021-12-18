require 'day01'

RSpec.describe Day01 do
  let(:day01) do
    "R5, L2, L1, R1, R3, R3, L3, R3, R4, L2, R4, L4, R4, R3, L2, L1, L1, R2, R4, R4, L4, R3, L2, R1, L4, R1, R3, L5, L4, L5, R3, L3, L1, L1, R4, R2, R2, L1, L4, R191, R5, L2, R46, R3, L1, R74, L2, R2, R187, R3, R4, R1, L4, L4, L2, R4, L5, R4, R3, L2, L1, R3, R3, R3, R1, R1, L4, R4, R1, R5, R2, R1, R3, L4, L2, L2, R1, L3, R1, R3, L5, L3, R5, R3, R4, L1, R3, R2, R1, R2, L4, L1, L1, R3, L3, R4, L2, L4, L5, L5, L4, R2, R5, L4, R4, L2, R3, L4, L3, L5, R5, L4, L2, R3, R5, R5, L1, L4, R3, L1, R2, L5, L1, R4, L1, R5, R1, L4, L4, L4, R4, R3, L5, R1, L3, R4, R3, L2, L1, R1, R2, R2, R2, L1, L1, L2, L5, L3, L1"
  end

  context 'part1' do
    subject { described_class.part1 input }

    context 'example 1' do
      let(:input) { 'R2, L3' }
      it { is_expected.to eq 5 }
    end

    context 'example 2' do
      let(:input) { 'R2, R2, R2' }
      it { is_expected.to eq 2 }
    end

    context 'example 3' do
      let(:input) { 'R5, L5, R5, R3' }
      it { is_expected.to eq 12 }
    end

    context 'problem' do
      let(:input) { day01 }
      it { is_expected.to eq 287 }
    end
  end

  context 'part2' do
    subject { described_class.part2 input }

    context 'example' do
      let(:input) { 'R8, R4, R4, R8' }
      it { is_expected.to eq 4 }
    end

    context 'problem' do
      let(:input) { day01 }
      it { is_expected.to eq 133 }
    end
  end
end
