require "./spec_helper"

describe Random::XoShiRo128Plus do
  seed = UInt32.static_array(
    0x012de1ba_u32, 0xa5a818b8_u32, 0xb124ea2b_u32, 0x18e03749_u32,
  )

  it "#new" do
    Random::XoShiRo128Plus.new # preferred
    Random::XoShiRo128Plus.new(0xdeadbeef_u64)
    Random::XoShiRo128Plus.new(seed)
  end

  it "#next_u" do
    sequence = UInt32.static_array(
      0x1a0e1903_u32, 0xfde55c35_u32, 0xddb16b2e_u32, 0xab949ac5_u32,
      0xb5519fea_u32, 0xc6a97473_u32, 0x1f0403d9_u32, 0x1bb46995_u32,
      0x79c99a12_u32, 0xe447ebce_u32, 0xa8c31d78_u32, 0x54d8bbe3_u32,
      0x4984a039_u32, 0xb411e932_u32, 0x9c1f2c5e_u32, 0x5f53c469_u32,
      0x7f333552_u32, 0xb368c7a1_u32, 0xa57b8e66_u32, 0xb29a9444_u32,
      0x5c389bfa_u32, 0x8e7d3758_u32, 0xfe17a1bb_u32, 0xcd0aad57_u32,
      0xde83c4bb_u32, 0x1402339d_u32, 0xb557a080_u32, 0x4f828bc9_u32,
      0xde14892d_u32, 0xbba8eaed_u32, 0xab62ebbb_u32, 0x4ad959a4_u32,
      0x3c6ee9c7_u32, 0x4f6a6fd3_u32, 0xd5785eed_u32, 0x1a0227d1_u32,
      0x81314acb_u32, 0xfabdfb97_u32, 0x7e1b7e90_u32, 0x57544e23_u32,
    )
    rng = Random::XoShiRo128Plus.new(seed)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#jump" do
    sequence = UInt32.static_array(
      0x65ddc942_u32, 0x7e7c4d6b_u32, 0x6745a785_u32, 0x40897788_u32,
      0xfb60ce92_u32, 0x121f2ee0_u32, 0xd000bae8_u32, 0x52b3ebfc_u32,
      0x62fc3720_u32, 0xf880f092_u32, 0x7753c1ab_u32, 0x1e76a627_u32,
      0xe5de31e8_u32, 0xc7b1503f_u32, 0xa5557a66_u32, 0x37b2b2cd_u32,
      0x656dde58_u32, 0xdd5f1b93_u32, 0xba61298b_u32, 0xbd5d1ce2_u32,
      0xea4a5a73_u32, 0x0f10981d_u32, 0xc207a68c_u32, 0x1897adca_u32,
      0x4d729b07_u32, 0xf0115ee0_u32, 0x953d9e4b_u32, 0x3608e61c_u32,
      0x0c14c065_u32, 0xf2ed7579_u32, 0xcd96ef9b_u32, 0xdb62d117_u32,
      0x844e4713_u32, 0x763a8a76_u32, 0x9ad37470_u32, 0x211e4883_u32,
      0xc8682b75_u32, 0xb1831941_u32, 0xf0c50a84_u32, 0x7321dc33_u32,
    )
    original = Random::XoShiRo128Plus.new(seed)

    rng = original.jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#long_jump" do
    sequence = UInt32.static_array(
      0x93572bc7_u32, 0xc46a6c83_u32, 0x5803ee73_u32, 0x525cc155_u32,
      0x45d27ce5_u32, 0xfffbdf72_u32, 0x764d4d47_u32, 0xe94e5ee4_u32,
      0xf91b0e1f_u32, 0x63138833_u32, 0xb63f1a97_u32, 0x5cf78346_u32,
      0xad979a8f_u32, 0xcf4c0d3f_u32, 0xccfb1798_u32, 0xff978ea1_u32,
      0xc7744b7c_u32, 0xfcae345e_u32, 0x40618bc9_u32, 0x55f2ffd7_u32,
      0x869ad599_u32, 0x0101eba4_u32, 0x5091a478_u32, 0xc82b9461_u32,
      0x940e4e36_u32, 0x49f41fbe_u32, 0x6005f4af_u32, 0x6cf46dab_u32,
      0x2de3bc75_u32, 0x06530e45_u32, 0x839ef4b3_u32, 0xd2510032_u32,
      0x6053afee_u32, 0xe67eb5e8_u32, 0x2f25e700_u32, 0x2de3212b_u32,
      0x41cf6954_u32, 0xa66d8fd8_u32, 0x6c348704_u32, 0xb16b8da5_u32,
    )
    original = Random::XoShiRo128Plus.new(seed)

    rng = original.long_jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#split" do
    original = Random::XoShiRo128Plus.new(0xdeadbeef_u64)
    original.next_u.should eq(0x472255cc_u32)

    rng = original.split
    rng.should_not be(original)
    rng.next_u.should eq(0xbbc0480a_u32)
  end
end
