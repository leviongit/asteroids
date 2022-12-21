class Line
  class << self
    alias [] new

    def from_coordinate_pair(begin_, end_)
      self[begin_, end_ - begin_]
    end
  end

  def initialize(begin_, span, r = 255, g = r, b = g, a = 255)
    @begin = begin_
    @span = span
    @r = r
    @g = g
    @b = b
    @a = a
  end

  def move_by!(vector)
    @begin.add!(vector)
    self
  end

  def rotate_around!(point, radians)
    @begin.sub!(point).rotate!(radians).add!(point)
    @span.rotate!(radians)
    self
  end

  def scale!(scalar)
    @begin.mul!(scalar)
    @span.mul!(scalar)
    self
  end

  def scale(scalar)
    Line[@begin * scalar, @span * scalar]
  end

  def to_s
    "Line[#{@begin}, #{@span}, #{@r}, #{@g}, #{@b}, #{@a}]"
  end

  def draw_override(ffi)
    end_ = @begin + @span
    ffi.draw_line_2(@begin.x, @begin.y, end_.x, end_.y, @r, @g, @b, @a, 1)
  end

  def end
    @begin + @span
  end

  alias inspect to_s

  attr_accessor :r, :g, :b, :a
end
