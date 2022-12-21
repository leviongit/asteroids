class Game
  def at_t0
  end

  def initialize(args)
    @args = args
    @outputs = args.outputs
    @inputs = args.inputs

    @center = Vec2[640, 360]

    # @my_favourite_lines = [
    #   Line[Vec2[610, 390], Vec2[60, 0]],
    #   Line[Vec2[610, 360], Vec2[60, 0]],
    #   Line[Vec2[610, 330], Vec2[60, 0]],
    #   Line[Vec2[610, 330], Vec2[0, 60]],
    #   Line[Vec2[640, 330], Vec2[0, 60]],
    #   Line[Vec2[670, 330], Vec2[0, 60]]
    # ].each { _1.rotate_around!(@center, -0.1) }

    # begin
    #   @center_cross = [
    #     Line[@center.dup, r0 = Vec2[640, 0]],
    #     Line[@center.dup, r1 = ~r0],
    #     Line[@center.dup, r2 = ~r1],
    #     Line[@center.dup, ~r2]
    #   ]
    # end

    # @center_cross.each { |v|
    #   v.r = 255
    #   v.g = v.b = 0
    # }

    @ship_lines = [
      Vec2[0, 32],
      Vec2[48, 16],
      Vec2[0],
      Vec2[16, 16]
    ]
    # @ship_lines.each { _1.scale!(127).add!(Vec2[0, 1]) }

    @ship = Player[
      @ship_lines,
      pos: Vec2[100, 100]
    ]

    at_t0
  end

  def tick
    @outputs.background_color = [13, 21, 29]
    # @outputs.lines.concat(@my_favourite_lines)
    # @outputs.lines.concat(@center_cross)

    # @my_favourite_lines.each { _1.rotate_around!(@center, 0.01) }

    @outputs.sprites << @ship

    keys_held = @inputs.keyboard.key_held

    @ship.rotate_deg!(-@inputs.left_right * 3)
    @ship.accel if keys_held.w
    @ship.tick

    if keys_held.r
      $game = nil
    end
  end
end
