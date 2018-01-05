local Joypad = {}

require("tools/keys")

function Joypad:init()
  local joypad = {}
  joypad.joy = nil
  local joypads = love.joystick.getJoysticks()
  joypad.available = false
  if #joypads ~= 0 then
    joypad.joy = joypads[1]
    self.available = true
  else
  end
  -- in relate to https://love2d.org/wiki/GamepadButton
  joypad.buttons = { x = 1, y = 2, a = 3, b = 4, leftBumper = 5, rightBumper = 6, leftTrigger = 7, rightTrigger = 8, leftStick = 9, rightStick = 10,
    back = 11, start = 12}
  joypad.axes = { leftStick_leftRight = 1, leftStick_upDown = 2, rightStick_leftDown = 3, rightStick_upDown = 4 }
  joypad.stickAxis = { left = -1, center = 0, right = 1, up = -1, down = 1}

  function joypad:isAvailable()
    return self.available
  end 
  
  function joypad:checkJoypad()
    if self.available then
      if joypad.joy:getHat(1) == "r" or joypad.joy:getAxis(1) == 1 then
        keys.right.pressed = true
      elseif joypad.joy:getHat(1) == "l" or joypad.joy:getAxis(1) == -1 then
        keys.left.pressed = true
      end
      
      if joypad.joy:getHat(1) == "u" or joypad.joy:getAxis(2) == -1 then
        keys.up.pressed = true
      elseif joypad.joy:getHat(1) == "d" or joypad.joy:getAxis(2) == 1 then
        keys.down.pressed = true
      end
      
      if joypad.joy:getHat(1) == "ru" then
        keys.right.pressed = true
        keys.up.pressed = true
      elseif joypad.joy:getHat(1) == "rd" then
        keys.right.pressed = true
        keys.down.pressed = true
      end
      
      if joypad.joy:getHat(1) == "lu" then
        keys.left.pressed = true
        keys.up.pressed = true
      elseif joypad.joy:getHat(1) == "ld" then
        keys.left.pressed = true
        keys.down.pressed = true
      end
    end
      self:checkButtons()
  end
  
  
  
  function joypad:checkButtons()
    if self.available then
      if self.joy:isDown(self.buttons.x) then
        keys.action.pressed = true
      end
      
      if self.joy:isDown(self.buttons.rightBumper) then
        keys.reverseShoot.pressed = true
      end
      
      if self.joy:isDown(self.buttons.a) then
        keys.special.pressed = true
      end
  
      if self.joy:isDown(self.buttons.back) then
        keys.paused.pressed = true -- not keys.paused.pressed
      end
    end
  end

  
  return joypad
end

return Joypad