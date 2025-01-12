extends Node3D

@onready var grappling_hook: Node3D = $"grappling hook"
@onready var player: Node3D = $player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.retract_hook.connect(grappling_hook.remove)
	player.throw_hook.connect(grappling_hook.attach_hook)
