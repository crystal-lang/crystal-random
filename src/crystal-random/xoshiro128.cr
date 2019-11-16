require "./splitmix64"

# Based on the original implementation by David Blackman and Sebastiano Vigna
# (vigna@acm.org)
#
# To the extent possible under law, the author has dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# See <http://creativecommons.org/publicdomain/zero/1.0/>.

abstract class Random::XoShiRo128
  include Random

  # The multiplier to convert the least significant 24-bits of an Int32 to a
  # Float32.
  private FLOAT_UNIT = 1_f32 / (1 << 24)

  private JUMP_COEFFICIENTS = UInt32.static_array(
    0x8764000b_u32,
    0xf542d2d3_u32,
    0x6fa035c3_u32,
    0x77f2db5b_u32,
  )

  private LONG_JUMP_COEFFICIENTS = UInt32.static_array(
    0xb523952e_u32,
    0x0b6f099f_u32,
    0xccf5a0ef_u32,
    0x1c580662_u32,
  )

  @state : StaticArray(UInt32, 4)

  # Initializes the internal state using `SplitMix64` and a secure random seed.
  def self.new
    r = SplitMix64.new
    seed = StaticArray(UInt64, 2).new { r.next_u }
    new(seed.unsafe_as(StaticArray(UInt32, 4)))
  end

  # Initializes the internal state using `SplitMix64` and the given seed.
  def self.new(seed : UInt64)
    r = SplitMix64.new(seed)
    seed = StaticArray(UInt64, 2).new { r.next_u }
    new(seed.unsafe_as(StaticArray(UInt32, 4)))
  end

  def initialize(@state : StaticArray(UInt32, 4))
  end

  # Reinitializes the internal state using `SplitMix64` initialized with a
  # secure random seed.
  def new_seed : Nil
    r = SplitMix64.new
    seed = StaticArray(UInt64, 2).new { r.next_u }
    @state = seed.unsafe_as(StaticArray(UInt32, 4))
  end

  @[AlwaysInline]
  private def rotl(x : UInt32, k : Int32)
    (x << k) | (x >> (32 &- k))
  end

  # Returns the next 32-bit integer.
  def next_u : UInt32
    s = @state
    result = yield s

    t = s[1] << 9

    s.to_unsafe[2] ^= s.to_unsafe[0]
    s.to_unsafe[3] ^= s.to_unsafe[1]
    s.to_unsafe[1] ^= s.to_unsafe[2]
    s.to_unsafe[0] ^= s.to_unsafe[3]

    s.to_unsafe[2] ^= t

    s.to_unsafe[3] = rotl(s.to_unsafe[3], 11)

    @state = s
    result
  end

  # Returns the next 32-bit float.
  def next_float : Float32
    # require the least significant 24-bits so shift the higher bits across
    (v >> 8) * FLOAT_UNIT
  end

  # Simulates 2^64 calls to `next_u`, allowing to generate non-overlapping
  # sequences for parallel computations.
  def jump : self
    copy = dup
    copy.perform_jump(JUMP_COEFFICIENTS)
    copy
  end

  # Simulates 2^96 calls to `next_u`; it can be used to generate 2^32 starting
  # points, from each of which `jump` will generate 2^32 non-overlapping
  # subsequences for parallel distributed computations.
  def long_jump : self
    copy = dup
    copy.perform_jump(LONG_JUMP_COEFFICIENTS)
    copy
  end

  protected def perform_jump(table) : Nil
    s0 = 0_u32
    s1 = 0_u32
    s2 = 0_u32
    s3 = 0_u32

    table.each do |x|
      32.times do |b|
        if (x & 1_u32 << b) != 0
          s0 ^= @state.to_unsafe[0]
          s1 ^= @state.to_unsafe[1]
          s2 ^= @state.to_unsafe[2]
          s3 ^= @state.to_unsafe[3]
        end
        next_u
      end
    end

    @state.to_unsafe[0] = s0
    @state.to_unsafe[1] = s1
    @state.to_unsafe[2] = s2
    @state.to_unsafe[3] = s3
  end

  # Returns a new instance that shares no mutable state with this instance.
  def split
    self.class.new(@state.map { |s| murmurhash3(s) })
  end

  @[AlwaysInline]
  private def murmurhash3(x : UInt32) : UInt32
    x ^= x >> 16
    x &*= 0x85ebca6b_u32
    x ^= x >> 13
    x &*= 0xc2b2ae35_u32
    x ^= x >> 16
  end
end
