extends Spatial

export var baking_delay_frames := 0

var _baking_begin_time_ms = null

onready var _navigation_mesh_instance = find_node("NavigationMeshInstance")


func _ready():
	for _i in range(baking_delay_frames):
		yield(get_tree(), 'idle_frame')
	_navigation_mesh_instance.connect("bake_finished", self, "_on_bake_finished")
	_baking_begin_time_ms = OS.get_ticks_msec()
	_navigation_mesh_instance.bake_navigation_mesh()
	print("baking started")


func _on_bake_finished():
	var baking_end_time_ms = OS.get_ticks_msec()
	print("baking finished, took {0} [ms]".format([baking_end_time_ms - _baking_begin_time_ms]))
