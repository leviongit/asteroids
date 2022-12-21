def tick(args)
  $game ||= Game.new(args)
  $game.tick
end
