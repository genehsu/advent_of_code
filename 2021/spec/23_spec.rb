require 'day23'

RSpec.describe Day23 do
  let(:example) do
    <<~EODATA.split(/\n/)
      #############
      #...........#
      ###B#C#B#D###
        #A#D#C#A#
        #########
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 12521 }
    end

    context "problem" do
      let(:input) { day23 }
      let(:answer) { 14510 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 44169 }
    end

    context "problem" do
      let(:input) { day23 }
      let(:answer) { 49180 }
      it { is_expected.to eq answer }
    end
  end
end

def day23
  <<~EODATA.split(/\n/)
    #############
    #...........#
    ###B#A#B#C###
      #C#D#D#A#
      #########
  EODATA
end
