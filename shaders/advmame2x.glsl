// https://gist.github.com/singron/3161079#file-fragment-glsl-L6
// http://wiki.scummvm.org/index.php/User_Manual/Appendix:_Graphic_filters

extern sampler2D texture;
extern vec2 textureDimensions;

varying vec2 texCoord;

void main() {
	// o = offset, the width of a pixel
	vec2 o = 1.0 / textureDimensions;
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

