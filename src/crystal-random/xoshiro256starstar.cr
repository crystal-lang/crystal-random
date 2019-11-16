require "./xoshiro256"

# Based on the original implementation by David Blackman and Sebastiano Vigna
# (vigna@acm.org).
#
# To the extent possible under law, the author has dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# See <http://creativecommons.org/publicdomain/zero/1.0/>.

# xoshiro256** 1.0
#
# An all-purpose, rock-solid PRNG. Generates 64-bit random numbers using
# 256-bits of internal state that should be enough for any concurrent
# application. Passes all tests for the authors are aware of.
#
# Consider `Xoshiro128StarStar` if you're tight on memory space for low-scale
# concurrent programs.
#
# For generating just floating-point numbers, `XoShiRo256Plus` is even faster.
#
# NOTE: not suitable for cryptography or secure purposes.
#
# See <http://xoshiro.di.unimi.it/>
class Random::XoShiRo256StarStar < Random::XoShiRo256
  def next_u : UInt64
    super { |s| rotl(s.to_unsafe[1] &* 5, 7) &* 9 }
  end
end
