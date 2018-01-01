-- steering keys for player
keys =
{
  up = { val = "up", pressed = false },
  down = { val = "down", pressed = false },
  left = { val = "left", pressed = false },
  right = { val = "right", pressed = false },
  -- please don't use space because of this:
  -- https://gamedev.stackexchange.com/questions/108996/how-to-avoid-ghosting-when-pressing-multiple-keys/109002#109002
  action = { val = "rctrl", pressed = false },
  reverseShoot = { val = "rshift", pressed = false },
  special = { val = "return", pressed = false },
  paused = { val = "p", pressed = false }
}

-- DEPRICATED
pressedKeys =
{
  up = false,
  down = false,
  left = false,
  right = false,
  action = false,
  special = false
}
