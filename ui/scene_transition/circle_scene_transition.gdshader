shader_type canvas_item;

uniform vec2 center_px = vec2(0, 0);
uniform float radius_percent = 1;

void fragment() {
	float radius_px = radius_percent / min(SCREEN_PIXEL_SIZE.x, SCREEN_PIXEL_SIZE.y) * sqrt(2.0);
	
	vec2 pos = UV / SCREEN_PIXEL_SIZE;
	float alpha = length(center_px - pos) > radius_px ? 1.0 : 0.0;
	COLOR.a = alpha;
}