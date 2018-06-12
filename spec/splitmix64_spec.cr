require "./spec_helper"

describe Random::SplitMix64 do
  seed = 0xdeadbeef_u64

  it "#new" do
    Random::SplitMix64.new(seed) # okayish
    Random::SplitMix64.new # preferred
  end

  it "#next_u" do
    sequence = [
      0x4adfb90f68c9eb9b_u64, 0xde586a3141a10922_u64, 0x021fbc2f8e1cfc1d_u64, 0x7466ce737be16790_u64,
      0x3bfa8764f685bd1c_u64, 0xab203e503cb55b3f_u64, 0x5a2fdc2bf68cedb3_u64, 0xb30a4ccf430b1b5a_u64,
      0x0a90415039bd5985_u64, 0x26ae50847745eb7e_u64, 0xe239ed306d9b1929_u64, 0xfb7d9a8d444d41bc_u64,
      0x1bb52e523960d559_u64, 0xcf8631b40292b5d5_u64, 0xf6186c41b838b122_u64, 0x432497ffb78c1173_u64,
      0x138be7aff970bf01_u64, 0x9539d89821a47c8a_u64, 0xc571c21baca507b9_u64, 0x1c0e38e2ceb0016b_u64,
    ]
    rng = Random::SplitMix64.new(seed)
    sequence.each { |expected| rng.next_u.should eq(expected) }
  end
end
