shader_type canvas_item;

global uniform vec4 topleft:source_color;
global uniform vec4 topright:source_color;
global uniform vec4 bottomleft:source_color;
global uniform vec4 bottomright:source_color;

global uniform vec4 topleftbg:source_color;
global uniform vec4 toprightbg:source_color;
global uniform vec4 bottomleftbg:source_color;
global uniform vec4 bottomrightbg:source_color;

uniform bool background = false;
void fragment() {
	if (background) {
		vec4 top = mix(topleftbg, toprightbg, SCREEN_UV.x);
		vec4 bottom = mix(bottomleftbg, bottomrightbg, SCREEN_UV.x);
		float alpha = COLOR.a;
		COLOR =  mix(top, bottom, SCREEN_UV.y);
		COLOR.a = alpha;
	}
	else{
		vec4 top = mix(topleft, topright, SCREEN_UV.x);
		vec4 bottom = mix(bottomleft, bottomright, SCREEN_UV.x);
		float alpha = COLOR.a;
		COLOR =  mix(top, bottom, SCREEN_UV.y);
		COLOR.a = alpha;
	}
}
