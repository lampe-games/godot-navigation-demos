extends RigidBody

const USE_LINEAR_VELOCITY = true

export var speed := 2.0
export var distance_to_go = 10.0  # m

var _moving = false

onready var _navi = find_node("NavigationAgent")


func _ready():
	_navi.set_navigation(find_parent("Navigation"))
	_navi.connect("velocity_computed", self, "_on_safe_velocity_computed")
	_navi.connect("target_reached", self, "_on_target_reached")
	move_forward(distance_to_go)


func _physics_process(_delta):
	if not _moving:
		_navi.set_velocity(Vector3.ZERO)
		return
	var target = _navi.get_next_location()
	var pos = global_transform.origin
	var velocity = (target - pos).normalized() * speed
	_navi.set_velocity(velocity)


func move_forward(distance):
	if distance == 0.0:
		return
	var target = global_transform * Vector3(0, 0, -distance)
	_navi.set_target_location(target)
	_moving = true


func _on_safe_velocity_computed(safe_velocity):
	if USE_LINEAR_VELOCITY:
		set_linear_velocity(safe_velocity)
	else:
		global_transform.origin += safe_velocity * 0.01666666


func _on_target_reached():
	set_linear_velocity(Vector3.ZERO)
	_moving = false
	# _navi.disconnect("velocity_computed", self, "_on_safe_velocity_computed")
