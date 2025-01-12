extends TextureRect

var t: float = 0;
var t_speed: float = 1;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta * t_speed;
	material.set_shader_parameter("t", t)

func set_strength(strength: float) -> void:
	material.set_shader_parameter("strength", strength + 0.6)
	t_speed = (0.5 + strength) / 2
