extends Node3D

@onready var rope: MeshInstance3D = $rope
@onready var mount: MeshInstance3D = $mount

var connected_to: Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	#RenderingServer.instance_set_ignore_culling(rope.mesh.get_rid(), true) # cause using the shader for chaning the shape and it would get wierd otherwise

func connect_to(where: Vector3) -> void:
	rope.transform = Transform3D(
		Basis.looking_at((where-position).cross(Vector3(0,1,0).cross(where-position).normalized()))
		* Basis().scaled(Vector3(1,where.distance_to(position), 1)),
		(where-position)/2
	)
	 

func attach_hook(where: Vector3, what: Node3D) -> void:
	position = where
	visible = true
	connected_to = what

func remove() -> void:
	visible = false
	connected_to = null

func _process(delta: float) -> void:
	if connected_to != null:
		connect_to(connected_to.position)
