shader_type canvas_item;

uniform sampler2D sigma;

void fragment() {
	vec2 distoredUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.5 ;
	vec4 screenColor = texture(sigma, SCREEN_UV);
	COLOR = screenColor;
}

