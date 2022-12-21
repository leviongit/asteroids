class Polygon
  class << self
    alias [] new
  end

  def initialize(points, r = 255, g = r, b = g, a = 255, pos: Vec2[], angle: 0, args: $args, **kwd)
    v01 = Vec2[0, 1]
    @points = points.map(&:dup)
    @points.each { _1.add!(v01) }
    @args = args
    @rt = args.outputs[@name = :"Polygon__#{object_id}"]
    @r = r
    @g = g
    @b = b
    @a = a
    @angle = angle
    @pos = pos
    @dw = @rt.w = @w = points.map(&:x).minmax.inject(0, :-).abs + 1
    @dh = @rt.h = @h = points.map(&:y).minmax.inject(0, :-).abs + 1

    redraw!
  end

  def scale!(scalar)
    @points.each { _1.scale!(scalar) }
  end

  def remake_lines!
    @lines = [*@points, @points[0]].each_cons(2).map { |(b, e)|
      Line.from_coordinate_pair(b, e).tap { |l|
        l.r = @r
        l.g = @g
        l.b = @b
        l.a = @a
      }
    }
  end

  def redraw!
    remake_lines!

    @rt = @args.outputs[@name]
    @rt.w = @w
    @rt.h = @h
    @rt.lines.concat(@lines)
  end

  def draw_override(ffi)
    ffi.draw_sprite_4(
      @pos.x,
      @pos.y,
      @dw,
      @dh,
      @name.to_s,
      @angle,
      @a,
      @r,
      @g,
      @b,
      -1,
      -1,
      @dw,
      @dh,
      false,
      false,
      0.5,
      0.5,
      -1,
      -1,
      @dw,
      @dh,
      1
    )
  end

  def r=(value)
    @r = value
    redraw!
  end

  def g=(value)
    @g = value
    redraw!
  end

  def b=(value)
    @b = value
    redraw!
  end

  def a=(value)
    @a = value
    redraw!
  end

  def reset_display_size!
    @dw = @w
    @dh = @h
    self
  end

  def to_s
    "Polygon[#{@points}, #{@r}, #{@g}, #{@b}, #{@a}, pos: #{@pos}, angle: #{@angle}, w: #{@w}, h: #{@h}]"
  end

  attr_accessor :x, :y, :angle, :dw, :dh
  attr_reader :r, :g, :b, :a, :w, :h, :name
end
