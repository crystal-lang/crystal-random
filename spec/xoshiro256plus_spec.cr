require "./spec_helper"

describe Random::XoShiRo256Plus do
  seed = UInt64.static_array(
    0x012de1babb3c4104_u64, 0xa5a818b8fc5aa503_u64, 0xb124ea2b701f4993_u64, 0x18e0374933d8c782_u64,
  )

  it "#new" do
    Random::XoShiRo256Plus.new # preferred
    Random::XoShiRo256Plus.new(0xdeadbeef_u64)
    Random::XoShiRo256Plus.new(seed)
  end

  it "#next_u" do
    sequence = UInt64.static_array(
      0x1a0e1903ef150886_u64, 0x08b605f47abc5d75_u64, 0xd82176096ac9be31_u64, 0x8fbf2af9b4fa5405_u64,
      0x9ab074b448171964_u64, 0xfd68cc83ab4360aa_u64, 0xf431f7c0c8dc6f2b_u64, 0xc04430be08212638_u64,
      0xc1ad670648f1da03_u64, 0x3eb70d38796ba24a_u64, 0x0e474d0598251ed2_u64, 0xf9b6b3b56482566b_u64,
      0x3d11e529ae07a7c8_u64, 0x3b195f84f4db17e7_u64, 0x09d62e817b8223e2_u64, 0x89dc4db9cd625509_u64,
      0x52e04793fe977846_u64, 0xc052428d6d7d17cd_u64, 0x6fd6f8da306b10ef_u64, 0x64a7996ba5cc80aa_u64,
      0x03abf59b95a1ef20_u64, 0xc5a82fc3cfb50234_u64, 0x0d401229eabb2d39_u64, 0xb537b249f70bd18a_u64,
      0x1af1b703753fcf4d_u64, 0xb84648c1945d9ccb_u64, 0x1d321bea673e1f66_u64, 0x93d4445b268f305f_u64,
      0xc046cfa36d89a312_u64, 0x8cc2d55bbf778790_u64, 0x1d668b0a3d329cc7_u64, 0x81b6d533dfcf82de_u64,
      0x9ca1c49a18537b16_u64, 0x68e55c4054e0cb72_u64, 0x06ed1956cb69afc6_u64, 0x4871e696449da910_u64,
      0xcfbd7a145066d46e_u64, 0x10131cb15004b62d_u64, 0x489c91a322bca3b6_u64, 0x8ec95fa9bef73e66_u64,
    )
    rng = Random::XoShiRo256Plus.new(seed)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#jump" do
    sequence = UInt64.static_array(
      0x894cd8014fa285ab_u64, 0x9737ec9aba91e4b6_u64, 0xf53b956d74db413a_u64, 0x6fb0350e20edef6b_u64,
      0x1babe425f938088f_u64, 0x04f33708a2103773_u64, 0x03a3f59f511629df_u64, 0x9d7323fd9cc8f542_u64,
      0x8df0f8083323117b_u64, 0x9097a2cc69730c34_u64, 0x54e01393f7e1c5f6_u64, 0x14971cb42dce9e33_u64,
      0x6ee4f7da32d287fe_u64, 0x36124f300901b735_u64, 0x71726514f0341cca_u64, 0xbdd6ff5845590a93_u64,
      0x75982d4223903b23_u64, 0x75e88dbec205937c_u64, 0x82fa1ef5ed2d3ff5_u64, 0x49983b880a0758b8_u64,
      0x8d3d74acd90595cc_u64, 0x1176ea450c32b01f_u64, 0xfddac8dca767aee0_u64, 0xbd8226c3f021dcfd_u64,
      0xf95c1aead608a5f9_u64, 0xc7bd37c9a128d4f2_u64, 0x8abc94eb440371ce_u64, 0x4f86410df47f6928_u64,
      0xd2d3479afe5730fe_u64, 0xa7e02f6550aa6668_u64, 0x5f8b8630e9f5814e_u64, 0xe8c605350467cdcc_u64,
      0xecc91d6be68b5d11_u64, 0xbe9382f9d9e9e205_u64, 0xb512c7b80ca731f1_u64, 0x5125f56b47a89007_u64,
      0x6d98bfd64342222b_u64, 0x7244f91ff7efc522_u64, 0xbcf26439fef5555f_u64, 0xce657c86d81455ce_u64,
    )
    original = Random::XoShiRo256Plus.new(seed)

    rng = original.jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#long_jump" do
    sequence = UInt64.static_array(
      0x1cf7608ee3f54c71_u64, 0xd9ec5faa2133c458_u64, 0xee0c3c44ac9a4571_u64, 0x8e6dd93270d03b83_u64,
      0x44268688ca3c44b2_u64, 0x07aefb00d1cd925f_u64, 0x3733c3fe9831692d_u64, 0x2d2c5df21bfd31b2_u64,
      0x1253a79c879276c2_u64, 0xf862b65e4bcb6bcf_u64, 0xf6dbb01651a1b8b5_u64, 0x68476e3a6b9bf559_u64,
      0xb135e7151bafae3e_u64, 0x6e905be176bb02bf_u64, 0xa5ee1972ed7e090c_u64, 0x2cad1fadf7be52d6_u64,
      0x1a34866325f9ae69_u64, 0xec4f680ff02209c1_u64, 0x4f01371b2db5a1c3_u64, 0x566fb6f85561d4d0_u64,
      0x75fec1eb21866b41_u64, 0xfaff7b899909d846_u64, 0xe9e1bc7229c28446_u64, 0x63389a9af17857c5_u64,
      0x07233b15e9f42541_u64, 0x46e262e3ba5c337c_u64, 0xfac8e73ae594bbd9_u64, 0x990562a1cbaf25d8_u64,
      0xd99269c3ac01c7a0_u64, 0x20c249266bba8447_u64, 0x947bf8bc4e0e8dea_u64, 0xbd69e3c43fa8582a_u64,
      0x7fb6e0e0d918bba6_u64, 0x95633e090da85696_u64, 0x1529c0b55ede291b_u64, 0x9034b247848dc3be_u64,
      0x6422cc4a32efeb31_u64, 0x6334a19977a2fca6_u64, 0x016a2c7af8cf0eef_u64, 0x49dab6a0dc871a1c_u64,
    )
    original = Random::XoShiRo256Plus.new(seed)

    rng = original.long_jump
    rng.should_not be(original)

    sequence.each { |expected| rng.next_u.should eq(expected) }
  end

  it "#split" do
    original = Random::XoShiRo256Plus.new(0xdeadbeef_u64)
    original.next_u.should eq(0xbf468782e4ab532b_u64)

    rng = original.split
    rng.should_not be(original)
    rng.next_u.should eq(0xef2817c89dfe32e1_u64)
  end
end
