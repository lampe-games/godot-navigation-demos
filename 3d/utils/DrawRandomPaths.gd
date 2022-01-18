extends ImmediateGeometry

export(Vector3) var range_begin
export(Vector3) var range_end
export(int, 1, 999999) var speed = 1
export(bool) var optimize_path = false
export(bool) var clear_each_time = false

onready var _navigation = get_parent()
onready var _timer = find_node("Timer")

var _rng = RandomNumberGenerator.new()


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")
	_timer.start(1 / float(speed))


func _draw_single_path():
	var begin = _get_random_navigation_point_in_range()
	var end = _get_random_navigation_point_in_range()
	var path = _navigation.get_simple_path(begin, end, optimize_path)
	if path != null and path.size() > 1:
		begin(Mesh.PRIMITIVE_LINE_STRIP)
		for point in path:
			set_color(Color.black)
			set_normal(Vector3(0, 1, 0))
			add_vertex(point)
		end()


func _get_random_navigation_point_in_range():
	return Vector3(
		_rng.randf_range(range_begin.x, range_end.x),
		range_begin.y,
		_rng.randf_range(range_begin.z, range_end.z)
	)


func _on_timer_timeout():
	if clear_each_time:
		clear()
	_draw_single_path()
