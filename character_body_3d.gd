extends RigidBody3D

@onready var ray_cast: RayCast3D = $Camera3D/RayCast3D
@onready var camera: Camera3D = $Camera3D
@onready var crosshair: TextureRect = $Camera3D/CanvasLayer/crosshair
@onready var speed: TextureRect = $Camera3D/CanvasLayer/speed

#const SPEED: float = 3.3
const FRICTION: float = 1.
#const REDIRECTION_SPEED: float = 2
const MOUSE_SENSITIVITY: float = 0.005
#const DOUBLE_CLICK_SPEED = 0.5
const HOOK_FORCE: float = 10.

var double_click_timer = 0

func _unhandled_input(event) -> void:
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion: 
		camera.rotation.y = (camera.rotation.y -event.relative.x * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x -event.relative.y * MOUSE_SENSITIVITY, -PI/2, PI/2)
	
	if event.is_action_pressed("foward"):
		toggle_hook()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#if double_click_timer <= 0:
			#double_click_timer = DOUBLE_CLICK_SPEED
		#else:
			#double_click_timer = 0
			#toggle_hook()

var hook_out: bool = false
var hook_connection_point: Vector3

signal retract_hook
signal throw_hook(where: Vector3, what: Node3D)

func _process(delta: float) -> void:
	if not hook_out:
		if ray_cast.is_colliding():
			crosshair.close()
		else:
			crosshair.open()
	
	speed.set_strength((sqrt( change_in_speed * 0.3 + (linear_velocity + Vector3(0,linear_velocity.y,0)).length())-2.)/6.)

func toggle_hook() -> void:
	if hook_out:
		hook_out = false
		retract_hook.emit()
		crosshair.close()
	else:
		if ray_cast.is_colliding():
			hook_out = true
			throw_hook.emit(ray_cast.get_collision_point(), self)
			hook_connection_point = ray_cast.get_collision_point()
			crosshair.x()


var previous_speed: Vector3 = Vector3(0,0,0)
var change_in_speed: float = 0

func _physics_process(delta: float) -> void:
	#if is_on_floor():
		#velocity *= exp(-delta * FRICTION) # linear drag
		##if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			##velocity -= transform.basis.z * Vector3(SPEED,0,SPEED) * delta
	#else:
	#linear_velocity += get_gravity() * delta
	
	if hook_out:
		linear_velocity += (hook_connection_point - position) * delta * HOOK_FORCE
	
	change_in_speed = lerpf(change_in_speed, linear_velocity.distance_to(previous_speed) / delta, delta * 10.)
	previous_speed = linear_velocity
	#make_velocity_forward(delta)
	#move_and_collide()
	
	if position.y < -30:
		position = Vector3(0, 30, 0)
		linear_velocity = Vector3(0,0,0)



#func make_velocity_forward(delta: float) -> void:
	## aka air control - but also applies while on the ground
	#var horizontal_velocity := Vector2(velocity.x,velocity.z)
	#var goal_dir := Vector2(-transform.basis.z.x, -transform.basis.z.z)
	#var goal_mag := goal_dir.dot(horizontal_velocity)
	#var goal := goal_dir * goal_mag
	#var new_velocity = horizontal_velocity.slerp(goal, delta*REDIRECTION_SPEED)
	#velocity.x = new_velocity.x
	#velocity.z = new_velocity.y
