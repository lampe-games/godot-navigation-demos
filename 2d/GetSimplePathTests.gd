extends Node2D

@export var optimize := false


func _ready():
	await get_tree().create_timer(0.1).timeout  # TODO: use get_tree().idle_frame(?)
	var paths_to_draw = get_node("PathsToDraw")
	for path_node in paths_to_draw.get_children():
		var begin_point = path_node.get_node("Begin")
		var end_point = path_node.get_node("End")
		assert(begin_point and end_point)
		var map_rid = get_world_2d().get_navigation_map()
		var path = NavigationServer2D.map_get_path(map_rid, begin_point.position, end_point.position, optimize)
		if path == null or path.size() == 0: # no .empty() (?)
			continue
		add_child(_make_path(path))


func _make_path(path):
	var line = Line2D.new()
	line.default_color = Color.BLACK
	line.width = 2
	for point in path:
		line.add_point(point)
	return line
