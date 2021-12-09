require 'day06'

RSpec.describe "Day 6" do
  subject  { grow_fish_6 input, days }

  context "Part 1" do
    let(:days) { 80 }

    context "example" do
      let(:input) { example06 }

      it { is_expected.to eq 5934}
    end

    context "problem" do
      let(:input) { day06 }
      let(:answer) { 361169 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    let(:days) { 256 }

    context "example" do
      let(:input) { example06 }
      it { is_expected.to eq 26_984_457_539 }
    end

    context "problem" do
      let(:input) { day06 }
      let(:answer) { 1_634_946_868_992 }
      it { is_expected.to eq answer }
    end
  end
end

def example06
  [3,4,3,1,2]
end

def day06
  [1,1,3,5,3,1,1,4,1,1,5,2,4,3,1,1,3,1,1,5,5,1,3,2,5,4,1,1,5,1,4,2,1,4,2,1,4,4,1,5,1,4,4,1,1,5,1,5,1,5,1,1,1,5,1,2,5,1,1,3,2,2,2,1,4,1,1,2,4,1,3,1,2,1,3,5,2,3,5,1,1,4,3,3,5,1,5,3,1,2,3,4,1,1,5,4,1,3,4,4,1,2,4,4,1,1,3,5,3,1,2,2,5,1,4,1,3,3,3,3,1,1,2,1,5,3,4,5,1,5,2,5,3,2,1,4,2,1,1,1,4,1,2,1,2,2,4,5,5,5,4,1,4,1,4,2,3,2,3,1,1,2,3,1,1,1,5,2,2,5,3,1,4,1,2,1,1,5,3,1,4,5,1,4,2,1,1,5,1,5,4,1,5,5,2,3,1,3,5,1,1,1,1,3,1,1,4,1,5,2,1,1,3,5,1,1,4,2,1,2,5,2,5,1,1,1,2,3,5,5,1,4,3,2,2,3,2,1,1,4,1,3,5,2,3,1,1,5,1,3,5,1,1,5,5,3,1,3,3,1,2,3,1,5,1,3,2,1,3,1,1,2,3,5,3,5,5,4,3,1,5,1,1,2,3,2,2,1,1,2,1,4,1,2,3,3,3,1,3,5]
end
