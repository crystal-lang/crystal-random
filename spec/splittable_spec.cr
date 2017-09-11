require "./spec_helper"

describe Random::Splittable do
  it "#new" do
    Random::Splittable.new(12345_u64) # okayish
    Random::Splittable.new # preferred
  end

  it "#next_u" do
    # test vectors generated using Vigna's C port of splitmix64 modified by
    # Lemire. See https://github.com/lemire/testingRNG/blob/master/source/splitmix64.h
    numbers = UInt64.static_array(
      5395234354446855067_u64,
      16021672434157553954_u64,
      153047824787635229_u64,
      8387618351419058064_u64,
      4321915660117851420_u64,
      12330924294077242175_u64,
      6498654868697050547_u64,
      12901208535622949722_u64,
      761180149847513477_u64,
      2787253749255891838_u64,
      16301321118497315113_u64,
      18121810407135723964_u64,
      1996552940493526361_u64,
      14953694261937354197_u64,
      17733042562290725154_u64,
      4838159024254620019_u64,
      1408474051473620737_u64,
      10752863733234826378_u64,
      14227366121956509625_u64,
      2021615829517336939_u64,
    )
    rng = Random::Splittable.new(0xdeadbeef_u64)
    numbers.each do |expected|
      rng.next_u.should eq(expected)
    end
  end

  it "#next_int" do
    rng = Random::Splittable.new(12345_u64)
    rng.next_int.should eq(-1526108289)
    rng.next_int.should eq(384012526)
    rng.next_int.should eq(-422007946)
  end

  it "#next_float" do
    rng = Random::Splittable.new(12345_u64)
    rng.next_float.should eq(0.1330796686614273)
    rng.next_float.should eq(0.20481663336165912)
    rng.next_float.should eq(0.11954258300911547)
  end

  it "#split" do
    rng = Random::Splittable.new(12345_u64)

    rng = rng.split
    rng.next_u.should eq(15328130456064710858_u64)

    rng = rng.split
    rng.next_u.should eq(9989932672924920245_u64)
  end
end
