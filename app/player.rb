class Player < Polygon
  def initialize(...)
    super
    @vel = Vec2[]
    @bounds = Vec2[1280, 720]
  end

  def tick
    @pos.add!(@vel)
    @vel.mul!(0.99)
    @pos.mod!(@bounds)
  end

  def accel
    rangle = @angle * 0.01745329251994329577
    @vel.add!(Vec2.from_polar(0.5, rangle))
  end

  def slow
    rangle = @angle * 0.01745329251994329577
    @vel.sub!(Vec2.from_polar(0.5, rangle))
  end

  def rotate_deg!(degrees)
    @angle += degrees
  end

  def rotate!(radians)
    @angle += radians / 0.01745329251994329577
  end
end
