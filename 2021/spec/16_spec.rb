require 'day16'

RSpec.describe Day16 do
  let (:example) do
    <<~EODATA.split(/\n/)
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example 1" do
      let(:input) { "8A004A801A8002F478" }

      it { is_expected.to eq 16 }
    end

    context "example 1" do
      let(:input) { "620080001611562C8802118E34" }

      it { is_expected.to eq 12 }
    end

    context "example 1" do
      let(:input) { "C0015000016115A2E0802F182340" }

      it { is_expected.to eq 23 }
    end

    context "example 1" do
      let(:input) { "A0016C880162017C3686B18A3D4780" }

      it { is_expected.to eq 31 }
    end

    context "problem" do
      let(:input) { AocInput.read_line(16) }
      let(:answer) { 925 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example 1" do
      let(:input) { "C200B40A82" }

      it { is_expected.to eq 3 }
    end

    context "example 2" do
      let(:input) { "04005AC33890" }

      it { is_expected.to eq 54 }
    end

    context "example 3" do
      let(:input) { "880086C3E88112" }

      it { is_expected.to eq 7 }
    end

    context "example 4" do
      let(:input) { "CE00C43D881120" }

      it { is_expected.to eq 9 }
    end

    context "example 5" do
      let(:input) { "D8005AC2A8F0" }

      it { is_expected.to eq 1 }
    end

    context "example 6" do
      let(:input) { "F600BC2D8F" }

      it { is_expected.to eq 0 }
    end

    context "example 7" do
      let(:input) { "9C005AC2F8F0" }

      it { is_expected.to eq 0 }
    end

    context "example 8" do
      let(:input) { "9C0141080250320F1802104A08" }

      it { is_expected.to eq 1 }
    end

    context "problem" do
      let(:input) { AocInput.read_line(16) }
      let(:answer) { 342997120375 }
      it { is_expected.to eq answer }
    end
  end
end
