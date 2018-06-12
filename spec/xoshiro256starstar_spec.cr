require "./spec_helper"

describe Random::XoShiRo256StarStar do
  seed = UInt64.static_array(
    0x012de1babb3c4104_u64, 0xa5a818b8fc5aa503_u64, 0xb124ea2b701f4993_u64, 0x18e0374933d8c782_u64,
  )

  it "#new" do
    Random::XoShiRo256StarStar.new # preferred
    Random::XoShiRo256StarStar.new(0xdeadbeef_u64)
    Random::XoShiRo256StarStar.new(seed)
  end

  it "#next_u" do
    sequence = UInt64.static_array(
      0x462c422df780c48e_u64, 0xa82f1f6031c183e6_u64, 0x8a113820e8d2ca8d_u64, 0x1ac7023a26534958_u64,
      0xac8e41d0101e109c_u64, 0x46e34bc13edd63c4_u64, 0x3a26776adcd665c3_u64, 0x9ac6c9bea8fc518c_u64,
      0x1cef0aa07cc738c4_u64, 0x5136a5f070244b1d_u64, 0x12e2e12edee691ff_u64, 0x28942b20799b71b4_u64,
      0xbe2d5c4267af2469_u64, 0x9dbec53728b2b9b7_u64, 0x893cf86611b14a96_u64, 0x712c226c79f066d6_u64,
      0x1a8a11ef81d2ac60_u64, 0x28171739ef8f2f46_u64, 0x073baa93525f8b1d_u64, 0xa73c7f3cb93df678_u64,
      0xae5633ab977a3531_u64, 0x25314041ba2d047e_u64, 0x31e6819dea142672_u64, 0x9479fa694f4c2965_u64,
      0xde5b771a968472b7_u64, 0xf0501965d9eeb4a3_u64, 0xef25a2a8ec90b911_u64, 0x1f58f71a75392659_u64,
      0x32d9547188781f3c_u64, 0x2d13b036ccf65bc0_u64, 0x289f9cc038dd952f_u64, 0x6ae2d5231e50824a_u64,
      0x75651acfb42ab170_u64, 0x7369aeb4f10056cf_u64, 0x0297ed632a97cf75_u64, 0x19f534c778015b72_u64,
      0x5d1d111c5ff182a8_u64, 0x861cdfe8e8014b96_u64, 0x07c6071e08112c83_u64, 0x15601582dcf4e4fe_u64,
    )
    rng = Random::XoShiRo256StarStar.new(seed)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#jump" do
    sequence = UInt64.static_array(
      0xb416bd07926c6735_u64, 0x2f91faf5c6c9f79a_u64, 0x538d25a148318bc1_u64, 0x79ffea0eb76500e6_u64,
      0x7b74b0513602a5e1_u64, 0xdc114ef0bb881ac5_u64, 0xa0845293613f458b_u64, 0xb650a96e30f09819_u64,
      0xbd2aeb7eb2ac1a6a_u64, 0x724e2d39d21b00ba_u64, 0x4b38be1deb8553ca_u64, 0xd83f40c399601212_u64,
      0x97aba644588c210a_u64, 0x5caa9f64a83047b6_u64, 0x36ade013e70660ab_u64, 0xf1bf69a51790aada_u64,
      0x4c25aad6aac062dd_u64, 0x072e1ab91c2ec7c1_u64, 0x9343a09f5f5eec61_u64, 0xdcdd0baaaa38bce7_u64,
      0x0c0ea0bcd389f16a_u64, 0x0765633fee36d533_u64, 0xfba7f80666c43a76_u64, 0x896323052d851b9c_u64,
      0x60bdd013e4a0a3f3_u64, 0x244be4b11b49ca4c_u64, 0x1513dcbe57a23089_u64, 0x809e9476dd32f1ba_u64,
      0x09e914013550ced8_u64, 0x68873250d4a070b9_u64, 0x0c7709d63a915660_u64, 0x97014b396d121b71_u64,
      0xc50b646fe0f40c95_u64, 0x4edff941823be25c_u64, 0x5310e5528d79fa55_u64, 0xb7353ccef26265e9_u64,
      0x3346bda5d2ac2d7d_u64, 0xbeab7520abd736f1_u64, 0x7195e9c9f28eac6a_u64, 0x64d959048b71d87b_u64,
    )
    original = Random::XoShiRo256StarStar.new(seed)

    rng = original.jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#long_jump" do
    sequence = UInt64.static_array(
      0x01aeb600840f594f_u64, 0xb658457c13139b18_u64, 0x45de59065e34c7a1_u64, 0xee4e2dc3272cbddd_u64,
      0xab76ae6ad7b58827_u64, 0x1125e963c7de503d_u64, 0x262a3e31960c225c_u64, 0x6959383a6ca6db93_u64,
      0x162e98220db47855_u64, 0x8c241774ab03fb0f_u64, 0xa574997e9135c756_u64, 0x7d69f1c620f6e354_u64,
      0xebcaa8a26b1e0d11_u64, 0x7013a78241c67e80_u64, 0xd653dc4a68e9f576_u64, 0x54f483e05528cdee_u64,
      0x0f46d76b266f1bde_u64, 0xb5364248293168b0_u64, 0x83328b16fdd08b22_u64, 0x3c9241622a8ed2d3_u64,
      0x4fb5158c8ba832e9_u64, 0x98a540967c042253_u64, 0xfc215e6a07670358_u64, 0xafc3ccd56bc029be_u64,
      0xf0b16f5c1edf807a_u64, 0x02792082f4adc46f_u64, 0xe6203988ebcd9f8f_u64, 0xa3f9c62dc60e3a05_u64,
      0x9ec363a473ce3aff_u64, 0x2e787e5b4ff29d4d_u64, 0x89899eb9b705963f_u64, 0xc9114da1cad45697_u64,
      0xdb8fc78dc1fb839e_u64, 0xe537b60ba49474d5_u64, 0xcffb3215f6208209_u64, 0xbfdabe221f9c308c_u64,
      0x3d30cabb172af4b2_u64, 0xfd64f857f0f3b8d8_u64, 0x4b554d6b026bf8c1_u64, 0xf5ebb49acd5d6f24_u64,
    )
    original = Random::XoShiRo256StarStar.new(seed)

    rng = original.long_jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#split" do
    original = Random::XoShiRo256StarStar.new(0xdeadbeef_u64)
    original.next_u.should eq(0xc5555444a74d7e83_u64)

    rng = original.split
    rng.should_not be(original)
    rng.next_u.should eq(0x228bb75bc497d835_u64)
  end
end
