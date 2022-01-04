require 'day24'

RSpec.describe Day24 do
  describe described_class::ALU do
    subject { [alu.x, alu.y, alu.z, alu.w] }
    let(:alu) { described_class.new example }
    let(:example) do
      <<~EODATA.split(/\n/)
        inp w
        add z w
        mod z 2
        div w 2
        add y w
        mod y 2
        div w 2
        add x w
        mod x 2
        div w 2
        mod w 2
      EODATA
    end

    before { alu.run input }

    [[1, [0, 0, 1, 0]],
     [2, [0, 1, 0, 0]],
     [3, [0, 1, 1, 0]],
     [4, [1, 0, 0, 0]],
     [8, [0, 0, 0, 1]],
     [9, [0, 0, 1, 1]],
    ].each do |input, expected|
      context "run(#{input})" do
        let(:input) { input }
        it { is_expected.to eq expected }
      end
    end
  end

  context "run" do
    subject  { described_class.run code }

    let(:code) { AocInput.read(24) }
    it { is_expected.to be true }
  end
end
