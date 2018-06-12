require "./xoshiro128"

# Based on the original implementation by David Blackman and Sebastiano Vigna
# (vigna@acm.org)
#
# To the extent possible under law, the author has dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# See <http://creativecommons.org/publicdomain/zero/1.0/>.

# xoshiro128** 1.1
#
# An all-purpose, rock-solid PRNG. Generates 32-bit random numbers using
# 128-bits of internal state that is large enough for mild parallelism. Passes
# all tests for the authors are aware of.
#
# Consider `XoShiRo256StarStar` unless you're tight on memory space and don't
# need large scale concurrency.
#
# For generating just single-precision (i.e. `Float32`) floating-point numbers,
# `XoShiRo128Plus` is even faster.
#
# NOTE: not suitable for cryptography or secure purposes.
#
# See <http://xoshiro.di.unimi.it/>
class Random::XoShiRo128StarStar < Random::XoShiRo128
  # Returns the next 32-bit integer.
  def next_u : UInt32
    super { |s| rotl(s.to_unsafe[1] &* 5, 7) &* 9 }
  end
end
