shader_type spatial;

void vertex() {
	vec3 scale = vec3(length(MODEL_MATRIX[0].xyz), length(MODEL_MATRIX[1].xyz), length(MODEL_MATRIX[2].xyz));
	COLOR = vec4(VERTEX * scale, 1);
}

bool xor(bool a, bool b) {
	return (a || b) && !(a && b);
}

void fragment() {
	ROUGHNESS = 0.8;
	if (xor(xor(fract(COLOR.x*3.) > 0.5, fract(COLOR.y*3.) > 0.5), fract(COLOR.z*3.) > 0.5)) {
		if (xor(xor(fract(COLOR.x) > 0.5, fract(COLOR.y) > 0.5), fract(COLOR.z) > 0.5)) {
			ALBEDO = vec3(0.18,0.2,0.15);
		} else {
			ALBEDO = vec3(0.13,0.1,0.15);
		}
	} else {
		if (xor(xor(fract(COLOR.x) > 0.5, fract(COLOR.y) > 0.5), fract(COLOR.z) > 0.5)) {
			ALBEDO = vec3(0.53,0.6,0.55);
		} else {
			ALBEDO = vec3(0.5,0.45,0.5);
		}
	}
}
