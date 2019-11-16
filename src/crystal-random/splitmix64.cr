require "random/secure"

# Fixed-increment version of Java 8's SplittableRandom generator
# (`Random::Splittable`). Passes BigCrush and can be useful when 64 bits of
# state is needed.
#
# Internally used to seed `XoShiRo256StarStar` and `XoShiRo128StarStar`.
#
# NOTE: not suitable for cryptography or secure purposes.
#
# See <http://dx.doi.org/10.1145/2714064.2660195> and
# <http://docs.oracle.com/javase/8/docs/api/java/util/SplittableRandom.html>
class Random::SplitMix64
  include Random

  private GOLDEN_GAMMA = 0x9e3779b97f4a7c15_u64

  @seed : UInt64

  def self.new
    seed = uninitialized UInt8[8]
    Random::Secure.random_bytes(seed.to_slice)
    new(seed.unsafe_as(UInt64))
  end

  def initialize(@seed : UInt64)
  end

  def next_u : UInt64
    z = @seed &+= GOLDEN_GAMMA
    z = (z ^ (z >> 30)) &* 0xbf58476d1ce4e5b9_u64
    z = (z ^ (z >> 27)) &* 0x94d049bb133111eb_u64
    z ^ (z >> 31)
  end
end
