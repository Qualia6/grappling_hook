shader_type canvas_item;
render_mode unshaded;

uniform float t;
uniform float strength;
uniform float a;

void fragment() {
	float angle = atan(UV.y-0.5,UV.x-0.5);
	float fans1 = fract(t*0.7+angle*11.);
	float fans2 = fract(t*-1.5+angle*7.+0.33);
	float fans3 = fract(t*1.1+angle*5.+0.67);
	float r = length(UV - vec2(0.5));
	float central_removal = r * strength;
	float combined1 = step(fans1+fans2-central_removal, a);
	float combined2 = step(fans2+fans3-central_removal, a);
	float combined3 = step(fans3+fans1-central_removal, a);
	vec3 result = vec3(1) - vec3(combined1,combined2,combined3)*0.5;
	float alpha = clamp(combined1 + combined2 + combined3, 0, 1);
	COLOR = vec4(result,alpha);
}