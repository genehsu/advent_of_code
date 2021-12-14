require 'day14'

RSpec.describe Day14 do
  let (:example) do
    <<~EODATA.split(/\n/)
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 1588 }
    end

    context "problem" do
      let(:input) { day14 }
      let(:answer) { 2027 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 2188189693529 }
    end

    context "problem" do
      let(:input) { day14 }
      let(:answer) { 2265039461737 }
      it { is_expected.to eq answer }
    end
  end
end

def day14
  <<~EODATA.split(/\n/)
    PPFCHPFNCKOKOSBVCFPP

    VC -> N
    SC -> H
    CK -> P
    OK -> O
    KV -> O
    HS -> B
    OH -> O
    VN -> F
    FS -> S
    ON -> B
    OS -> H
    PC -> B
    BP -> O
    OO -> N
    BF -> K
    CN -> B
    FK -> F
    NP -> K
    KK -> H
    CB -> S
    CV -> K
    VS -> F
    SF -> N
    KB -> H
    KN -> F
    CP -> V
    BO -> N
    SS -> O
    HF -> H
    NN -> F
    PP -> O
    VP -> H
    BB -> K
    VB -> N
    OF -> N
    SH -> S
    PO -> F
    OC -> S
    NS -> C
    FH -> N
    FP -> C
    SO -> P
    VK -> C
    HP -> O
    PV -> S
    HN -> K
    NB -> C
    NV -> K
    NK -> B
    FN -> C
    VV -> N
    BN -> N
    BH -> S
    FO -> V
    PK -> N
    PS -> O
    CO -> K
    NO -> K
    SV -> C
    KO -> V
    HC -> B
    BC -> N
    PB -> C
    SK -> S
    FV -> K
    HO -> O
    CF -> O
    HB -> P
    SP -> N
    VH -> P
    NC -> K
    KC -> B
    OV -> P
    BK -> F
    FB -> F
    FF -> V
    CS -> F
    CC -> H
    SB -> C
    VO -> V
    VF -> O
    KP -> N
    HV -> H
    PF -> H
    KH -> P
    KS -> S
    BS -> H
    PH -> S
    SN -> K
    HK -> P
    FC -> N
    PN -> S
    HH -> N
    OB -> P
    BV -> S
    KF -> N
    OP -> H
    NF -> V
    CH -> K
    NH -> P
  EODATA
end
