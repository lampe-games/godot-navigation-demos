extends Node2D

export(Vector2) var range_begin
export(Vector2) var range_end
export(int, 1, 999999) var speed = 1
export(bool) var optimize_path = false
export(bool) var clear_each_time = false

var _rng = RandomNumberGenerator.new()

onready var _navigation = get_parent()
onready var _timer = find_node("Timer")


func _ready():
	_timer.connect("timeout", self, "_on_timer_timeout")
	_timer.start(1 / float(speed))


func _draw_single_path():
	var begin = _get_random_navigation_point_in_range()
	var end = _get_random_navigation_point_in_range()
	var path = _navigation.get_simple_path(begin, end, optimize_path)
	if path != null and path.size() > 1:
		var line = Line2D.new()
		line.default_color = Color.black
		line.width = 1
		for point in path:
			line.add_point(point)
		add_child(line)


func _get_random_navigation_point_in_range():
	return Vector2(
		_rng.randf_range(range_begin.x, range_end.x), _rng.randf_range(range_begin.y, range_end.y)
	)


func _on_timer_timeout():
	if clear_each_time:
		for child in get_children():
			if not child is Timer:
				child.queue_free()
	_draw_single_path()
