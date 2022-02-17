extends Spatial

onready var lines = find_node("ImmediateGeometry")


func _ready():
	yield(get_tree(), "idle_frame")
	for node in get_children():
		if not node is Navigation:
			continue
		var navigation = node
		var begin_point = navigation.find_node("Begin")
		var end_point = navigation.find_node("End")
		assert(begin_point and end_point)
		var path = navigation.get_simple_path(
			begin_point.transform.origin, end_point.transform.origin, false
		)
		_draw_path(path)


func _draw_path(path):
	print(path)
	if path != null and path.size() > 1:
		lines.begin(Mesh.PRIMITIVE_LINE_STRIP)
		for point in path:
			lines.set_color(Color.black)
			lines.set_normal(Vector3(0, 1, 0))
			lines.add_vertex(point)
		lines.end()
