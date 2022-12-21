class Vec2
  attr_accessor :x, :y

  class << self
    alias [] new

    def from_polar(magn, theta)
      m = Math
      Vec2[m.cos(theta) * magn, m.sin(theta) * magn]
    end
  end

  def initialize(x = 0, y = x)
    @x = x
    @y = y
  end

  def add!(vector)
    @x += vector.x
    @y += vector.y
    self
  end

  def add(vector)
    Vec2[@x + vector.x, @y + vector.y]
  end

  def sub!(vector)
    @x -= vector.x
    @y -= vector.y
    self
  end

  def sub(vector)
    Vec2[@x - vector.x, @y - vector.y]
  end

  def mul!(scalar)
    @x *= scalar
    @y *= scalar
    self
  end

  def mul(scalar)
    Vec2[@x * scalar, @y * scalar]
  end

  def div!(scalar)
    @x /= scalar
    @y /= scalar
    self
  end

  def div(scalar)
    Vec2[@x / scalar, @y / scalar]
  end

  def neg!
    @x = -@x
    @y = -@y
  end

  def neg
    Vec2[-@x, -@y]
  end

  def rot90!
    tx = -@y
    @y = @x
    @x = tx
    self
  end

  def rot90a!
    tx = @y
    @y = -@x
    @x = tx
    self
  end

  def rot90
    Vec2[-@y, @x]
  end

  def rot90a
    Vec2[@y, -@x]
  end

  def dot(vector)
    @x * vector.x + @y * vector.y
  end

  def wedge(vector)
    @x * vector.y - @y * vector.x
  end

  def magnitude_sq
    @x * @x + @y * @y
  end

  def magnitude
    (@x * @x + @y * @y) ** 0.5
  end

  def unit?
    (@x * @x + @y * @y) == 1
  end

  def zero?
    @x == 0 && @y == 0
  end

  def at(index, form = :programmer)
    if form.equal?(:programmer)
      if index == 0
        @x
      elsif index == 1
        @y
      else
        raise ArgumentError, "index must be an integer in the range [0, 1]"
      end
    elsif form.equal?(:math)
      if index == 1
        @x
      elsif index == 2
        @y
      else
        raise ArgumentError, "index must be an integer in the range [1, 2]"
      end
    else
      raise ArgumentError, "form must be either :programmer or :math"
    end
  end

  def to_a
    [@x, @y]
  end

  def to_h
    {
      x: @x,
      y: @y
    }
  end

  def to_s
    "Vec2[#{@x}, #{@y}]"
  end

  def map!(&f)
    @x = yield(@x)
    @y = yield(@y)
    self
  end

  def map(&f)
    Vec2[yield(@x), yield(@y)]
  end

  def eql?(other)
    ## to be debated later
    (Vec2 === other) && (@x == other.x) && (@y == other.y)
  end

  def neql?(other)
    !((Vec2 === other) && (@x == other.x) && (@y == other.y))
  end

  def angle
    Math.atan2(@y, @x)
  end

  def normalize!
    len_sq = @x * @x + @y * @y
    return self if len_sq == 0

    len = Math.sqrt(len_sq)
    @x /= len
    @y /= len
    self
  end

  def normalize
    len_sq = @x * @x + @y * @y
    return Vec2[] if len_sq == 0

    len = Math.sqrt(len_sq)
    Vec2[@x / len, @y / len]
  end

  def rotate!(radians)
    m = Math
    c = m.cos(radians)
    s = m.sin(radians)
    tx = c * @x - s * @y
    @y = s * @x + c * @y
    @x = tx

    self
  end

  def rotate(radians)
    m = Math
    c = m.cos(radians)
    s = m.sin(radians)
    Vec2[
      c * @x - s * @y,
      s * @x - c * @y
    ]
  end

  def clamp_top!(top_magn)
    return self if (sq_magn = (@x * @x + @y * @y)) <= (top_magn * top_magn)

    magn = sq_magn ** 0.5

    @x *= top_magn / magn
    @y *= top_magn / magn
    self
  end

  def mod!(vector)
    @x %= vector.x
    @y %= vector.y
    self
  end

  alias + add
  alias - sub
  alias scale! mul!
  alias scale mul
  alias * mul
  alias / div
  alias -@ neg
  alias ~ rot90
  alias ^ wedge
  alias length_sq magnitude_sq
  alias length magnitude
  alias [] at
  alias to_ary to_a
  alias to_hash to_h
  alias inspect to_s
  alias == eql?
  alias != neql?
end
