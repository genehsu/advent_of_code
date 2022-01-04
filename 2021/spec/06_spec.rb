require 'day06'

RSpec.describe Day06 do
  subject  { described_class.grow_fish input, days }

  let(:example) { [3,4,3,1,2] }

  context "Part 1" do
    let(:days) { 80 }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 5934}
    end

    context "problem" do
      let(:input) { AocInput.read_int_line(6) }
      let(:answer) { 361169 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    let(:days) { 256 }

    context "example" do
      let(:input) { example }
      it { is_expected.to eq 26_984_457_539 }
    end

    context "problem" do
      let(:input) { AocInput.read_int_line(6) }
      let(:answer) { 1_634_946_868_992 }
      it { is_expected.to eq answer }
    end
  end
end
