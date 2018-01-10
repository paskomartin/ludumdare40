local AdvMame2x = {}

function AdvMame2x:new()
  local shader = love.graphics.newShader [[
extern vec2 textureDimensions;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	// o = offset, the width of a pixel
	vec2 o = 1.0 / textureDimensions;
  vec2 texCoord = texture_coords;
	// texel arrangement
	// A B C
	// D E F
	// G H I
	vec4 A = Texel(texture, texCoord + vec2( -o.x,  o.y));
	vec4 B = Texel(texture, texCoord + vec2(    0,  o.y));
	vec4 C = Texel(texture, texCoord + vec2(  o.x,  o.y));
	vec4 D = Texel(texture, texCoord + vec2( -o.x,    0));
	vec4 E = Texel(texture, texCoord + vec2(    0,    0));
	vec4 F = Texel(texture, texCoord + vec2(  o.x,    0));
	vec4 G = Texel(texture, texCoord + vec2( -o.x, -o.y));
	vec4 H = Texel(texture, texCoord + vec2(    0, -o.y));
	vec4 I = Texel(texture, texCoord + vec2(  o.x, -o.y));
	vec2 p = texCoord * textureDimensions;
	// p = the position within a pixel [0...1]
	p = p - floor(p);
  vec4 pixel;

	if (p.x > .5) {
		if (p.y > .5) {
			// Top Right
			pixel = B == F && B != D && F != H ? F : E;
		} else {
			// Bottom Right
			pixel = H == F && D != H && B != F ? F : E;
		}
	} else {
		if (p.y > .5) {
			// Top Left
			pixel = D == B && B != F && D != H ? D : E;
		} else {
			// Bottom Left
			pixel = D == H && D != B && H != F ? D : E;
		}
	}
  return pixel;
}

]]

  return shader
end


return AdvMame2x
