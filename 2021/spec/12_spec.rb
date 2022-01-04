require 'day12'

RSpec.describe Day12 do
  context "Part 1" do
    subject  { described_class.part1 input }

    context "example 1" do
      let(:input) do
        <<~EODATA.split(/\n/)
          start-A
          start-b
          A-c
          A-b
          b-d
          A-end
          b-end
        EODATA
      end

      it { is_expected.to eq 10}
    end

    context "example 2" do
      let(:input) do
        <<~EODATA.split(/\n/)
          dc-end
          HN-start
          start-kj
          dc-start
          dc-HN
          LN-dc
          HN-end
          kj-sa
          kj-HN
          kj-dc
        EODATA
      end

      it { is_expected.to eq 19}
    end

    context "example 3" do
      let(:input) do
        <<~EODATA.split(/\n/)
          fs-end
          he-DX
          fs-he
          start-DX
          pj-DX
          end-zg
          zg-sl
          zg-pj
          pj-he
          RW-he
          fs-DX
          pj-RW
          zg-RW
          start-pj
          he-WI
          zg-he
          pj-fs
          start-RW
        EODATA
      end

      it { is_expected.to eq 226}
    end

    context "problem" do
      let(:input) { AocInput.read(12) }
      let(:answer) { 3463 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example 1" do
      let(:input) do
        <<~EODATA.split(/\n/)
          start-A
          start-b
          A-c
          A-b
          b-d
          A-end
          b-end
        EODATA
      end

      it { is_expected.to eq 36}
    end

    context "example 2" do
      let(:input) do
        <<~EODATA.split(/\n/)
          dc-end
          HN-start
          start-kj
          dc-start
          dc-HN
          LN-dc
          HN-end
          kj-sa
          kj-HN
          kj-dc
        EODATA
      end

      it { is_expected.to eq 103}
    end

    context "example 3" do
      let(:input) do
        <<~EODATA.split(/\n/)
          fs-end
          he-DX
          fs-he
          start-DX
          pj-DX
          end-zg
          zg-sl
          zg-pj
          pj-he
          RW-he
          fs-DX
          pj-RW
          zg-RW
          start-pj
          he-WI
          zg-he
          pj-fs
          start-RW
        EODATA
      end

      it { is_expected.to eq 3509}
    end

    context "problem" do
      let(:input) { AocInput.read(12) }
      let(:answer) { 91533 }
      it { is_expected.to eq answer }
    end
  end
end
