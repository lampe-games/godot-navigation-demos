extends Node2D


func _ready():
	yield(get_tree(), "idle_frame")
	for node in get_children():
		if not node is Navigation2D:
			continue
		var navigation = node
		for navigation_child in navigation.get_children():
			if not navigation_child is Position2D:
				continue
			var point = navigation_child
			var closest_point = navigation.get_closest_point(point.position)
			print("{0}/{1}: {2} -> {3}".format([navigation, point, point.position, closest_point]))
			add_child(_make_path(point.position, closest_point))


func _make_path(p1, p2):
	var line = Line2D.new()
	line.default_color = Color.black
	line.width = 2
	line.add_point(p1)
	line.add_point(p2)
	return line
