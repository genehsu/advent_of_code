require 'day19'

RSpec.describe Day19 do

  context "Part 1" do
    subject { described_class.part1 input, replacements }

    let(:replacements) do
      <<~'EODATA'.split(/\n/)
        H => HO
        H => OH
        O => HH
      EODATA
    end

    context "example 1" do
      let(:input) { "HOH" }
      it { is_expected.to eq 4 }
    end

    context "example 2" do
      let(:input) { "HOHOHO" }
      it { is_expected.to eq 7 }
    end

    context "problem" do
      let(:input) { day19_molecule }
      let(:replacements) { day19 }
      let(:answer) { 535 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject { described_class.part2 input, replacements }

    let(:replacements) do
      <<~'EODATA'.split(/\n/)
        e => H
        e => O
        H => HO
        H => OH
        O => HH
      EODATA
    end

    context "example 1" do
      let(:input) { "HOH" }
      it { is_expected.to eq 3 }
    end

    context "example 2" do
      let(:input) { "HOHOHO" }
      it { is_expected.to eq 6 }
    end

    context "problem" do
      let(:input) { day19_molecule }
      let(:replacements) { day19 }
      let(:answer) { 212 }
      it { is_expected.to eq answer }
    end
  end
end

def day19_molecule
  "CRnCaCaCaSiRnBPTiMgArSiRnSiRnMgArSiRnCaFArTiTiBSiThFYCaFArCaCaSiThCaPBSiThSiThCaCaPTiRnPBSiThRnFArArCaCaSiThCaSiThSiRnMgArCaPTiBPRnFArSiThCaSiRnFArBCaSiRnCaPRnFArPMgYCaFArCaPTiTiTiBPBSiThCaPTiBPBSiRnFArBPBSiRnCaFArBPRnSiRnFArRnSiRnBFArCaFArCaCaCaSiThSiThCaCaPBPTiTiRnFArCaPTiBSiAlArPBCaCaCaCaCaSiRnMgArCaSiThFArThCaSiThCaSiRnCaFYCaSiRnFYFArFArCaSiRnFYFArCaSiRnBPMgArSiThPRnFArCaSiRnFArTiRnSiRnFYFArCaSiRnBFArCaSiRnTiMgArSiThCaSiThCaFArPRnFArSiRnFArTiTiTiTiBCaCaSiRnCaCaFYFArSiThCaPTiBPTiBCaSiThSiRnMgArCaF".freeze
end

def day19
  <<~'EODATA'.split(/\n/)
    Al => ThF
    Al => ThRnFAr
    B => BCa
    B => TiB
    B => TiRnFAr
    Ca => CaCa
    Ca => PB
    Ca => PRnFAr
    Ca => SiRnFYFAr
    Ca => SiRnMgAr
    Ca => SiTh
    F => CaF
    F => PMg
    F => SiAl
    H => CRnAlAr
    H => CRnFYFYFAr
    H => CRnFYMgAr
    H => CRnMgYFAr
    H => HCa
    H => NRnFYFAr
    H => NRnMgAr
    H => NTh
    H => OB
    H => ORnFAr
    Mg => BF
    Mg => TiMg
    N => CRnFAr
    N => HSi
    O => CRnFYFAr
    O => CRnMgAr
    O => HP
    O => NRnFAr
    O => OTi
    P => CaP
    P => PTi
    P => SiRnFAr
    Si => CaSi
    Th => ThCa
    Ti => BP
    Ti => TiTi
    e => HF
    e => NAl
    e => OMg
  EODATA
end
