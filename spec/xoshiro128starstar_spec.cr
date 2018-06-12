require "./spec_helper"

describe Random::XoShiRo128StarStar do
  seed = UInt32.static_array(
    0x012de1ba_u32, 0xa5a818b8_u32, 0xb124ea2b_u32, 0x18e03749_u32,
  )

  it "#new" do
    Random::XoShiRo128StarStar.new # preferred
    Random::XoShiRo128StarStar.new(0xdeadbeef_u64)
    Random::XoShiRo128StarStar.new(seed)
  end

  # FIXME: sequences are for xoshiro128** 1.0 not version 1.1 !

  it "#next_u" do
    sequence = UInt32.static_array(
      0x462c2d0e_u32, 0xa82f1c66_u32, 0xb4ac5d78_u32, 0xc78ca9ce_u32,
      0x8f220d1c_u32, 0xd8482a15_u32, 0x3e748f25_u32, 0xaa3beac5_u32,
      0xef10c09b_u32, 0x03396cc9_u32, 0x513df551_u32, 0xd782d321_u32,
      0xd72b7a3c_u32, 0xee412058_u32, 0x53fcd416_u32, 0x1978df20_u32,
      0x915be8c6_u32, 0x73953a43_u32, 0xc5e0f517_u32, 0x7cb5418f_u32,
      0xc592a9fd_u32, 0x4b7ab053_u32, 0x8b174ebe_u32, 0x11822a36_u32,
      0x05a007a6_u32, 0xdc0eae19_u32, 0xb3037034_u32, 0x5d58adcd_u32,
      0xa5856849_u32, 0xbcbfd3c5_u32, 0x5acf2534_u32, 0x506a2507_u32,
      0xd54a3328_u32, 0x713f3db0_u32, 0x8c56efae_u32, 0xf9a88bca_u32,
      0x290c4be8_u32, 0xd862e6f6_u32, 0xcd478581_u32, 0x46d25d9b_u32,
    )
    rng = Random::XoShiRo128StarStar.new(seed)
    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#jump" do
    sequence = UInt32.static_array(
      0x576fc920_u32, 0xc3cbaa4d_u32, 0xd5756de6_u32, 0xe80f6b0d_u32,
      0x61d2e14f_u32, 0xeab0e2cc_u32, 0x023626d0_u32, 0xc72086a8_u32,
      0x8346653b_u32, 0x1f6fa7b0_u32, 0x7b9d58f4_u32, 0x323d5553_u32,
      0x1d7c075e_u32, 0x8803c7f6_u32, 0xc635f0dd_u32, 0xa38c0b5d_u32,
      0x1b6c70cb_u32, 0x08a1084c_u32, 0xf0bb82fc_u32, 0xb4976d42_u32,
      0xd5949cd6_u32, 0x0f1ef921_u32, 0x4ec4eb9d_u32, 0xa03e8f59_u32,
      0xb919225f_u32, 0x3adcb84a_u32, 0xeaef4e58_u32, 0x89dda432_u32,
      0x7fcb15c0_u32, 0x21f03687_u32, 0xb5eb0aee_u32, 0x1c28cb08_u32,
      0xb0160058_u32, 0xb20e50fb_u32, 0x79bcae62_u32, 0x9d26fb4a_u32,
      0x1c4e2ed5_u32, 0xc90bcffe_u32, 0xa3bb918e_u32, 0x2518e067_u32,
    )
    original = Random::XoShiRo128StarStar.new(seed)

    rng = original.jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#long_jump" do
    sequence = UInt32.static_array(
      0xfe1d78fb_u32, 0x0d276087_u32, 0xfb132ee8_u32, 0xfd14348e_u32,
      0x2fe79d66_u32, 0x911a7a0c_u32, 0x0ac37358_u32, 0xcb079fd9_u32,
      0x1af2f1c1_u32, 0x5a696014_u32, 0xa9f11bae_u32, 0xc4b6a527_u32,
      0xc3721047_u32, 0xd1fdc11c_u32, 0xdfc141bf_u32, 0x43520b8a_u32,
      0x679e4775_u32, 0x41e29fe8_u32, 0x00f5f29a_u32, 0xe90c6657_u32,
      0xe345acca_u32, 0x3bb6698b_u32, 0xad35b2b6_u32, 0x3f17e299_u32,
      0x6a10df1b_u32, 0x309d50f7_u32, 0x9d12ec88_u32, 0x686f769f_u32,
      0x5f4c61b6_u32, 0xef9b8b8b_u32, 0x031ecc43_u32, 0x2aff109c_u32,
      0x7cae86a1_u32, 0x905e417e_u32, 0x829b3853_u32, 0x027952d5_u32,
      0x895cccc6_u32, 0x2396d83d_u32, 0x0d643337_u32, 0xaff52560_u32,
    )
    original = Random::XoShiRo128StarStar.new(seed)

    rng = original.long_jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#split" do
    rng = Random::XoShiRo128StarStar.new(0xdeadbeef_u64)
    rng.next_u.should eq(0xa9c3d393_u32)

    rng = rng.split
    rng.next_u.should eq(0x61800258_u32)
  end
end
