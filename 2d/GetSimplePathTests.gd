extends Node2D

export var optimize := false


func _ready():
	yield(get_tree(), "idle_frame")
	for node in get_children():
		if not node is Navigation2D:
			continue
		var navigation = node
		var begin_point = navigation.find_node("Begin")
		var end_point = navigation.find_node("End")
		assert(begin_point and end_point)
		var path = navigation.get_simple_path(begin_point.position, end_point.position, optimize)
		print(path)
		if path == null or path.empty():
			return
		add_child(_make_path(path))


func _make_path(path):
	var line = Line2D.new()
	line.default_color = Color.black
	line.width = 2
	for point in path:
		line.add_point(point)
		var point_marker = Line2D.new()
		point_marker.default_color = Color.black
		point_marker.width = 2
		point_marker.add_point(point + Vector2(-5, -5))
		point_marker.add_point(point)
		point_marker.add_point(point + Vector2(5, -5))
		point_marker.add_point(point + Vector2(-5, 5))
		point_marker.add_point(point)
		point_marker.add_point(point + Vector2(5, 5))
		line.add_child(point_marker)
	return line
