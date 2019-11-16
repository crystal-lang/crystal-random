require "./xoshiro256"

# Based on the original implementation by David Blackman and Sebastiano Vigna
# (vigna@acm.org).
#
# To the extent possible under law, the author has dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# See <http://creativecommons.org/publicdomain/zero/1.0/>.

# xoshiro256+ 1.0
#
# For floating-point numbers. Generates 64-bit random numbers using 256-bits of
# internal state. Passes all tests for the authors are aware of, except for the
# lowest three bits, which might fail linearity tests (and just those), so if
# low linear complexity is not considered an issue (as it is usually the case)
# it can be used to generate 64-bit outputs, too.
#
# Consider `Xoshiro256StarStar` for a general purpose alternative that passes
# all tests the authors are aware of, albeit slightly slower.
#
# For generating just single-precision (i.e. `Float32`) floating-point numbers,
# `XoShiRo128Plus` is even faster.
#
# NOTE: not suitable for cryptography or secure purposes.
#
# See <http://xoshiro.di.unimi.it/>
class Random::XoShiRo256Plus < Random::XoShiRo256
  def next_u : UInt64
    super { |s| s.to_unsafe[0] &+ s.to_unsafe[3] }
  end
end
