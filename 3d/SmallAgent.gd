extends RigidBody

const USE_LINEAR_VELOCITY = true

export var speed := 2.0
export var distance_to_go = 10.0  # m

var _moving = true

onready var _navi = find_node("NavigationAgent")


func _ready():
	var target = global_transform * Vector3(0, 0, -distance_to_go)
	_navi.set_navigation(find_parent("Navigation"))
	_navi.set_target_location(target)
	_navi.connect("velocity_computed", self, "_on_safe_velocity_computed")
	_navi.connect("target_reached", self, "_on_target_reached")


func _physics_process(_delta):
	if not _moving:
		return
	var target = _navi.get_next_location()
	var pos = global_transform.origin
	var velocity = (target - pos).normalized() * speed
	_navi.set_velocity(velocity)


func _on_safe_velocity_computed(safe_velocity):
	if USE_LINEAR_VELOCITY:
		set_linear_velocity(safe_velocity)
	else:
		global_transform.origin += safe_velocity * 0.01666666


func _on_target_reached():
	set_linear_velocity(Vector3.ZERO)
	_moving = false
	# _navi.disconnect("velocity_computed", self, "_on_safe_velocity_computed")
