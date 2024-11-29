shader_type canvas_item;

uniform float intensity: hint_range(0.0, 5) = 0.0;

void fragment(){
	vec4 color = texture(TEXTURE, UV, intensity);
	color[3] = 1.5-UV[0]*2.0;
	COLOR = color;
}