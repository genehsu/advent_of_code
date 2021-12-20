require 'day19'

RSpec.describe Day19 do
  let(:example) do
    <<~EODATA.split(/\n/)
      --- scanner 0 ---
      404,-588,-901
      528,-643,409
      -838,591,734
      390,-675,-793
      -537,-823,-458
      -485,-357,347
      -345,-311,381
      -661,-816,-575
      -876,649,763
      -618,-824,-621
      553,345,-567
      474,580,667
      -447,-329,318
      -584,868,-557
      544,-627,-890
      564,392,-477
      455,729,728
      -892,524,684
      -689,845,-530
      423,-701,434
      7,-33,-71
      630,319,-379
      443,580,662
      -789,900,-551
      459,-707,401

      --- scanner 1 ---
      686,422,578
      605,423,415
      515,917,-361
      -336,658,858
      95,138,22
      -476,619,847
      -340,-569,-846
      567,-361,727
      -460,603,-452
      669,-402,600
      729,430,532
      -500,-761,534
      -322,571,750
      -466,-666,-811
      -429,-592,574
      -355,545,-477
      703,-491,-529
      -328,-685,520
      413,935,-424
      -391,539,-444
      586,-435,557
      -364,-763,-893
      807,-499,-711
      755,-354,-619
      553,889,-390

      --- scanner 2 ---
      649,640,665
      682,-795,504
      -784,533,-524
      -644,584,-595
      -588,-843,648
      -30,6,44
      -674,560,763
      500,723,-460
      609,671,-379
      -555,-800,653
      -675,-892,-343
      697,-426,-610
      578,704,681
      493,664,-388
      -671,-858,530
      -667,343,800
      571,-461,-707
      -138,-166,112
      -889,563,-600
      646,-828,498
      640,759,510
      -630,509,768
      -681,-892,-333
      673,-379,-804
      -742,-814,-386
      577,-820,562

      --- scanner 3 ---
      -589,542,597
      605,-692,669
      -500,565,-823
      -660,373,557
      -458,-679,-417
      -488,449,543
      -626,468,-788
      338,-750,-386
      528,-832,-391
      562,-778,733
      -938,-730,414
      543,643,-506
      -524,371,-870
      407,773,750
      -104,29,83
      378,-903,-323
      -778,-728,485
      426,699,580
      -438,-605,-362
      -469,-447,-387
      509,732,623
      647,635,-688
      -868,-804,481
      614,-800,639
      595,780,-596

      --- scanner 4 ---
      727,592,562
      -293,-554,779
      441,611,-461
      -714,465,-776
      -743,427,-804
      -660,-479,-426
      832,-632,460
      927,-485,-438
      408,393,-506
      466,436,-512
      110,16,151
      -258,-428,682
      -393,719,612
      -211,-452,876
      808,-476,-593
      -575,615,604
      -485,667,467
      -680,325,-822
      -627,-443,-432
      872,-547,-609
      833,512,582
      807,604,487
      839,-516,451
      891,-625,532
      -652,-548,-490
      30,-46,-14

    EODATA
  end

  context "Part 1" do
    subject  { described_class.part1 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 79 }
    end

    context "problem" do
      let(:input) { day19 }
      let(:answer) { 350 }
      it { is_expected.to eq answer }
    end
  end

  context "Part 2" do
    subject  { described_class.part2 input }

    context "example" do
      let(:input) { example }

      it { is_expected.to eq 3621 }
    end

    context "problem" do
      let(:input) { day19 }
      let(:answer) { 10895 }
      it { is_expected.to eq answer }
    end
  end
end

def day19
  <<~EODATA.split(/\n/)
    --- scanner 0 ---
    -837,-546,895
    545,-724,-398
    -105,-144,-62
    40,-27,65
    768,-521,353
    642,-596,-431
    676,498,843
    823,-657,349
    513,471,840
    341,513,-616
    -538,662,461
    -589,608,-546
    -591,446,456
    599,419,857
    -875,-389,809
    374,417,-744
    516,-715,-442
    -546,-660,-328
    407,533,-756
    801,-613,507
    -484,551,443
    -453,-735,-364
    -649,-663,-385
    -747,585,-558
    -685,578,-549
    -863,-517,772

    --- scanner 1 ---
    -618,328,857
    -392,524,-392
    698,-323,-530
    621,529,700
    532,556,625
    727,-608,858
    737,-392,-411
    -462,530,-468
    -644,436,949
    -666,337,873
    -908,-784,-518
    -669,-762,-530
    860,-407,-490
    -53,82,105
    -751,-809,-457
    -640,-531,478
    371,562,709
    -41,-87,-32
    -529,526,-278
    -659,-397,473
    764,822,-554
    840,759,-524
    -607,-420,559
    838,-555,821
    783,-589,860
    771,850,-460

    --- scanner 2 ---
    480,491,503
    -526,565,627
    -660,-847,-399
    -335,419,-428
    608,478,-490
    556,503,540
    809,-640,-557
    767,-583,665
    409,524,-442
    515,554,-473
    -414,-584,764
    -334,389,-567
    -413,425,-389
    107,-11,-127
    786,-503,-681
    -646,678,620
    738,-505,635
    -67,58,13
    -701,466,618
    -789,-725,-404
    -410,-612,789
    440,476,639
    -730,-841,-493
    -433,-685,840
    774,-719,-674
    781,-544,572

    --- scanner 3 ---
    452,-584,-591
    574,-514,-593
    378,338,677
    307,-670,678
    -714,-482,845
    -760,-681,797
    426,-724,603
    461,364,-459
    -501,-549,-784
    -684,-588,814
    14,-1,-67
    -819,262,859
    476,-669,580
    -490,-532,-513
    -456,-494,-737
    405,519,639
    -751,541,-526
    -813,340,898
    -737,338,-585
    400,432,568
    543,441,-451
    -97,-132,27
    672,323,-482
    491,-514,-633
    -849,261,720
    -635,491,-586

    --- scanner 4 ---
    -851,594,501
    415,534,-339
    -400,-694,-712
    842,-645,-746
    -770,-575,694
    447,619,-384
    751,-581,-815
    -331,-575,-673
    48,-36,133
    -588,522,-437
    640,429,768
    518,-827,554
    516,-713,417
    -791,656,615
    567,396,681
    573,574,749
    -539,569,-414
    -98,52,54
    522,-637,487
    -792,-587,933
    -777,498,553
    -715,557,-385
    -817,-648,776
    316,667,-322
    -415,-615,-835
    814,-551,-739

    --- scanner 5 ---
    905,-652,484
    -641,-695,495
    -789,-742,-440
    507,534,616
    880,-623,690
    -604,562,573
    -429,-640,493
    -631,446,474
    607,-347,-806
    -542,-520,486
    -341,785,-353
    519,-334,-621
    420,644,609
    480,709,670
    -391,641,-407
    679,-388,-630
    -694,-698,-463
    -382,799,-378
    775,481,-769
    91,-54,-58
    24,89,60
    832,465,-575
    -616,486,610
    759,445,-607
    891,-689,698
    -603,-680,-451

    --- scanner 6 ---
    -806,-771,-421
    -671,-753,-499
    -18,6,103
    427,606,554
    -441,918,903
    -459,984,870
    -450,754,-541
    461,661,412
    -727,-645,-511
    -458,831,-623
    654,-640,-674
    703,-663,-627
    758,-345,558
    527,-692,-639
    -480,-614,744
    441,722,514
    -515,-682,580
    -512,961,729
    569,763,-684
    -345,-647,669
    23,172,-24
    678,857,-706
    640,676,-679
    765,-487,649
    867,-457,582
    -481,872,-412

    --- scanner 7 ---
    362,874,-678
    -297,-736,690
    515,-520,-872
    710,-448,649
    507,-454,-883
    -556,-557,-528
    860,457,540
    -493,782,-580
    -354,484,683
    -669,811,-568
    -518,-738,-501
    -336,-814,696
    797,381,570
    461,857,-545
    -369,361,604
    719,-623,550
    721,-491,-897
    -627,-644,-523
    130,-51,-2
    888,450,634
    -285,523,564
    -475,-815,726
    493,812,-630
    -542,759,-533
    712,-503,437
    -62,-5,-98

    --- scanner 8 ---
    -768,-717,-777
    -14,-143,-33
    875,-554,518
    543,466,-836
    -580,-855,818
    485,455,386
    109,-7,55
    -643,739,-916
    -627,-853,796
    565,-556,-604
    -830,308,753
    -747,-611,-890
    656,-390,-590
    477,528,481
    -568,-884,660
    468,608,390
    788,-495,482
    -754,-679,-797
    629,-381,-643
    561,395,-829
    -841,337,556
    708,389,-858
    -778,256,674
    -587,682,-768
    -590,727,-684
    737,-617,490

    --- scanner 9 ---
    -725,-474,547
    -720,638,-616
    -700,-786,-368
    277,-717,-225
    464,429,798
    -865,705,-635
    -898,632,-548
    280,-601,-352
    -627,381,455
    667,839,-243
    551,-412,723
    -772,-523,570
    414,391,782
    652,648,-231
    -638,-726,-482
    -675,512,517
    -760,480,472
    484,-310,753
    -737,-650,518
    378,455,874
    330,-718,-453
    15,149,38
    -796,-712,-420
    21,-10,198
    460,-419,865
    724,864,-242

    --- scanner 10 ---
    -676,578,415
    -583,653,379
    -615,-423,677
    932,640,-721
    650,593,669
    611,572,612
    -292,767,-844
    158,-1,127
    909,769,-764
    724,-453,-384
    920,-591,684
    -426,-737,-471
    -480,650,436
    743,-517,-419
    -621,-311,652
    -488,-715,-588
    23,72,16
    899,811,-727
    -696,-406,610
    -526,-618,-539
    914,-476,553
    739,-362,-359
    -254,924,-758
    789,-573,583
    607,504,819
    -266,796,-721

    --- scanner 11 ---
    786,817,323
    750,-679,-621
    817,748,324
    716,-950,645
    -862,695,-747
    -123,-3,10
    -817,663,-662
    515,641,-420
    731,-792,522
    -461,-637,768
    -508,-755,-903
    486,435,-395
    449,649,-409
    -552,784,427
    -536,746,477
    793,794,411
    -439,-903,-839
    -441,-973,-891
    685,-819,596
    -16,-129,-66
    -424,-819,701
    804,-670,-781
    -879,794,-614
    -460,720,391
    791,-855,-693
    -460,-831,679

    --- scanner 12 ---
    -327,-510,-927
    -678,630,-569
    599,-732,-680
    803,-629,742
    608,-557,-779
    956,765,548
    811,-563,753
    -475,640,-502
    -811,327,271
    -693,-905,469
    -350,-554,-832
    -593,394,259
    521,272,-700
    825,703,500
    -517,-864,541
    597,-600,767
    4,-53,-2
    430,341,-764
    857,748,415
    -338,-572,-741
    606,-612,-567
    150,-49,-163
    -741,325,323
    458,348,-670
    -684,666,-543
    -508,-918,381

    --- scanner 13 ---
    540,412,432
    499,-447,-412
    560,490,-572
    313,-436,-350
    -609,615,740
    461,499,-397
    -651,-421,865
    -783,-449,-581
    671,-787,790
    697,-793,826
    -121,55,15
    673,497,-452
    -595,-475,972
    -777,-489,876
    -617,328,-688
    -690,277,-665
    476,321,501
    408,-459,-394
    570,349,508
    -684,642,651
    -913,-515,-626
    738,-584,800
    -935,-429,-666
    -589,353,-684
    18,-76,136
    -693,609,901

    --- scanner 14 ---
    130,40,29
    -804,667,-760
    -770,-343,761
    59,134,-113
    -338,-660,-567
    824,-427,-597
    874,-475,-553
    505,-816,566
    628,611,-544
    611,594,780
    -720,707,-630
    -330,-715,-403
    -666,811,642
    -743,699,589
    606,879,-549
    649,-709,592
    664,680,737
    -536,753,568
    -623,728,-736
    511,-585,563
    870,-448,-421
    634,784,-501
    -733,-497,757
    -702,-264,790
    -407,-761,-544
    624,676,649

    --- scanner 15 ---
    610,-828,725
    397,-645,-531
    837,418,-503
    -368,-524,-425
    -271,722,-357
    506,-533,-507
    -340,753,-358
    561,-851,678
    -294,729,-445
    -439,385,375
    499,-675,-598
    737,-880,690
    586,669,757
    6,-115,59
    -425,-881,628
    -294,-943,580
    -447,451,386
    803,473,-361
    -304,-616,-461
    823,534,-463
    -653,422,361
    624,488,730
    695,575,735
    -393,-926,713
    -342,-600,-511

    --- scanner 16 ---
    -459,676,715
    -517,546,641
    653,-621,812
    679,321,-476
    584,659,617
    489,-586,744
    -603,814,-687
    651,761,587
    504,-618,-831
    -676,-601,853
    675,652,475
    -542,633,-663
    363,-565,-854
    -590,-654,810
    -486,-624,-428
    -12,-108,17
    -391,-596,-476
    -659,-618,-471
    -594,-614,722
    -563,730,-557
    -571,753,662
    330,-547,-788
    821,355,-531
    564,-451,777
    719,335,-592

    --- scanner 17 ---
    -635,641,629
    -598,563,-628
    -697,554,-453
    -857,-310,866
    -450,-372,-675
    -44,35,72
    452,417,-341
    -545,-395,-631
    412,609,854
    -623,678,553
    -608,542,513
    346,-430,603
    451,516,840
    480,392,-337
    798,-365,-359
    -636,-383,-613
    553,341,-360
    -898,-285,852
    244,-351,647
    776,-451,-399
    -848,-339,708
    373,546,811
    345,-416,647
    -165,134,173
    646,-385,-444
    -810,561,-573

    --- scanner 18 ---
    -450,784,-692
    824,665,491
    658,565,-856
    -521,630,499
    -728,-718,-393
    884,706,648
    672,474,-690
    -295,-814,873
    -592,-659,-362
    845,-859,-529
    -414,697,-751
    -750,-671,-391
    865,-845,-567
    100,39,-6
    -422,646,-629
    781,-798,610
    -527,808,567
    711,538,-865
    760,-704,519
    -320,-757,872
    -511,-742,884
    695,-822,530
    810,739,568
    958,-838,-635
    -454,775,480

    --- scanner 19 ---
    -584,442,716
    29,-98,157
    478,394,642
    -448,-668,505
    -571,305,-472
    -530,323,641
    593,-657,-595
    -461,392,-465
    696,765,-391
    104,29,35
    -489,-719,-508
    -529,492,739
    572,416,751
    713,-544,-588
    762,776,-383
    725,790,-597
    -541,-744,522
    -413,-731,-471
    659,421,680
    401,-833,599
    -373,-746,-607
    402,-803,460
    480,-797,421
    -342,-698,474
    -636,365,-411
    768,-756,-586

    --- scanner 20 ---
    -827,814,-478
    -831,839,-506
    758,558,-582
    358,846,587
    -595,670,784
    346,-593,-733
    9,-98,2
    508,525,-573
    402,-612,-731
    -828,-339,531
    -581,-349,-741
    -808,890,-579
    269,-411,617
    289,755,651
    -511,-443,-735
    -715,677,671
    431,-327,657
    -540,668,572
    -907,-517,495
    597,552,-498
    365,818,681
    -89,72,39
    392,-396,538
    -452,-354,-619
    -906,-378,525
    291,-559,-694

    --- scanner 21 ---
    590,783,-345
    -745,-624,-738
    857,-496,341
    -616,863,-699
    533,-734,-749
    -111,-15,-94
    -731,-698,-661
    -768,797,760
    -574,886,759
    783,509,760
    -805,-665,-581
    -692,-785,712
    -681,745,-710
    -756,819,796
    374,855,-356
    809,595,684
    -840,-721,781
    726,-544,403
    606,-767,-662
    847,545,668
    600,-589,-730
    -702,839,-619
    399,798,-357
    758,-629,358
    -910,-773,779
    67,44,-4

    --- scanner 22 ---
    -734,-309,822
    694,597,-432
    -681,-713,-669
    -729,-806,-671
    -504,413,-478
    -727,-286,910
    -423,822,764
    670,484,669
    131,24,89
    -610,510,-457
    768,467,-374
    -758,-355,909
    711,-708,-607
    794,-734,-587
    595,-357,756
    528,491,760
    715,390,-486
    -720,-726,-731
    -478,788,906
    -634,329,-518
    640,382,736
    -539,808,804
    519,-383,842
    686,-754,-646
    611,-319,806

    --- scanner 23 ---
    97,-47,-11
    -437,564,456
    -536,-668,-635
    -527,-918,-602
    421,-784,-469
    -611,-757,-608
    -569,-882,428
    443,-722,-586
    735,-595,679
    -77,-104,120
    -307,609,522
    -603,671,-321
    -530,648,-270
    589,260,714
    -625,-989,482
    648,534,-438
    455,326,695
    752,-514,612
    -443,-893,496
    847,-589,654
    606,535,-437
    -285,649,436
    554,460,-449
    -631,667,-346
    520,341,596
    540,-684,-537

    --- scanner 24 ---
    335,507,659
    789,625,-474
    -450,-800,-511
    441,658,656
    477,526,758
    -383,-788,-293
    626,-533,809
    -423,-454,576
    -366,804,-447
    -381,-736,-363
    862,-678,-596
    -435,708,806
    -402,782,-435
    102,8,-15
    -369,684,776
    -69,90,34
    -445,-295,458
    764,-565,739
    -489,744,673
    774,748,-316
    778,-478,879
    -403,871,-629
    808,-518,-587
    849,-590,-411
    -415,-486,528
    743,699,-447

    --- scanner 25 ---
    599,481,-432
    22,-11,-104
    -379,-514,-593
    595,-712,468
    877,548,315
    822,684,319
    395,-677,-695
    669,-618,457
    476,-746,-577
    131,-96,62
    670,-660,456
    -454,-419,-635
    -460,-531,-660
    -783,659,861
    -821,816,775
    -649,-845,488
    -595,542,-419
    -809,688,738
    -492,545,-362
    -549,-726,556
    855,592,473
    461,-811,-676
    -587,-823,605
    696,609,-465
    -399,470,-398
    570,490,-476

    --- scanner 26 ---
    390,830,-821
    -339,-265,-482
    498,624,688
    796,-639,827
    -610,-520,457
    -691,651,-600
    521,577,639
    -469,553,450
    -692,-593,410
    643,-775,-316
    -849,-532,435
    919,-560,812
    -434,-341,-461
    643,-673,-302
    93,0,103
    -17,62,-33
    -417,649,376
    -733,647,-605
    469,612,512
    723,-799,-385
    -556,599,-568
    -531,711,436
    757,-520,896
    516,740,-742
    408,752,-686
    -317,-280,-456

    --- scanner 27 ---
    504,695,379
    -622,-772,694
    -806,425,528
    728,729,341
    -729,336,-414
    576,448,-491
    -907,372,-493
    -854,471,329
    -63,-67,23
    517,434,-694
    440,-699,-685
    -739,-693,729
    -823,501,435
    354,-756,-816
    -615,-556,706
    -892,-778,-869
    -803,-894,-810
    -897,-900,-740
    743,-832,756
    577,550,-644
    699,-791,708
    625,-767,740
    -868,366,-415
    775,684,396
    450,-654,-798

    --- scanner 28 ---
    -352,765,607
    -645,-531,448
    681,719,941
    529,528,-567
    719,-753,-590
    866,-662,590
    -287,888,-644
    624,701,851
    -550,-592,443
    -401,788,418
    434,576,-595
    803,-584,531
    702,571,-573
    633,-710,-537
    619,761,872
    846,-644,656
    -610,-712,-570
    60,25,103
    -693,-522,411
    -402,791,596
    -320,954,-626
    637,-622,-577
    -446,-644,-605
    -521,-677,-740
    -461,931,-573

    --- scanner 29 ---
    -374,-424,-662
    750,875,838
    428,-515,-390
    710,-591,868
    742,524,-355
    25,19,-1
    -400,-430,-626
    -758,-781,514
    -524,733,541
    492,-367,-321
    933,454,-385
    -669,443,-538
    -333,-633,-636
    -413,837,569
    -572,-770,576
    -477,456,-489
    774,572,-363
    -649,511,-425
    695,805,686
    638,-415,909
    -496,817,703
    550,-600,922
    440,-297,-323
    663,735,824
    -663,-758,558

  EODATA
end
