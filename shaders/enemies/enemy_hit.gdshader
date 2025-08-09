shader_type canvas_item;


uniform float color_percentage = 0.0;


void fragment() {
	COLOR.r = COLOR.r + color_percentage;
	COLOR.g = COLOR.g - color_percentage;
	COLOR.b = COLOR.b - color_percentage;
}
