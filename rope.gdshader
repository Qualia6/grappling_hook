shader_type spatial;

void fragment() {
	if (fract(UV.y * 500. + UV.x) > 0.2) {
		ALBEDO = vec3(0.8, 0.7, 0.5);
	} else {
		ALBEDO = vec3(0.4, 0.3, 0.2);
	}
}
