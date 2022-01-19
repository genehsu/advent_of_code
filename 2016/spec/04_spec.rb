require 'day04'

RSpec.describe Day04 do
  context "Part 1" do
    subject { described_class.part1 input }

    context "example" do
      let(:input) do
        <<~EODATA.split(/\n/)
          aaaaa-bbb-z-y-x-123[abxyz]
          a-b-c-d-e-f-g-h-987[abcde]
          not-a-real-room-404[oarel]
          totally-real-room-200[decoy]
        EODATA
      end
      it { is_expected.to eq 1514 }
    end

    context "problem" do
      let(:input) { AocInput.read(4) }
      let(:answer) { 185371 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input }

    context "decrypt" do
      subject { described_class.decrypt name, serial_id }
      let(:name) { "qzmt-zixmtkozy-ivhz" }
      let(:serial_id) { 343 }

      it { is_expected.to eq "very encrypted name" }
    end

    context "problem" do
      let(:input) { AocInput.read(4) }
      let(:answer) { 984 }
      it { is_expected.to eq answer }
    end
  end
end
