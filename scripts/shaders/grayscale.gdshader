shader_type canvas_item;
uniform bool is_enabled = false;

void fragment() {
	if (is_enabled == true)
	{
	    COLOR = texture(TEXTURE, UV);
	    float avg = (COLOR.r + COLOR.g + COLOR.b) / 3.0;
	    COLOR.rgb = vec3(avg)-0.25;
	}
}
