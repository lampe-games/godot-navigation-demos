extends Node3D

@export var optimize := false
@onready var lines = get_node("ImmediateGeometry").mesh  # find_node not working?


func _ready():
	await get_tree().create_timer(0.1).timeout  # TODO: use get_tree().idle_frame(?)
	for path_node in get_node("PathsToDraw").get_children():
		var begin_point = path_node.get_node("Begin")
		var end_point = path_node.get_node("End")
		assert(begin_point and end_point)
		var map_rid = get_world_3d().get_navigation_map()
		var path = NavigationServer3D.map_get_path(map_rid, begin_point.transform.origin, end_point.transform.origin, optimize)
		_draw_path(path)


func _draw_path(path):
	if path != null and path.size() > 1:
		lines.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
		for point in path:
			lines.surface_set_color(Color.BLACK)
			lines.surface_set_normal(Vector3(0, 1, 0))
			lines.surface_add_vertex(point)
		lines.surface_end()
