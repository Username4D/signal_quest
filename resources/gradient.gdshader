shader_type canvas_item;

uniform vec4 topleft:source_color;
uniform vec4 topright:source_color;
uniform vec4 bottomleft:source_color;
uniform vec4 bottomright:source_color;
void fragment() {
	vec4 top = mix(topleft, topright, SCREEN_UV.x);
	vec4 bottom = mix(bottomleft, bottomright, SCREEN_UV.x);
	float alpha = COLOR.a;
	COLOR =  mix(top, bottom, SCREEN_UV.y);
	COLOR.a = alpha;
}
