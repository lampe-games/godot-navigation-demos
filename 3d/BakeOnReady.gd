extends Node3D

@export var baking_delay_frames := 0
@export var baking_delay_ms := 0.0

var _baking_begin_time_ms = null

@onready var _navigation_region_3d = get_node("NavigationRegion3D")


func _ready():
	# TODO: wait N idle frames
	if baking_delay_ms > 0:
		await get_tree().create_timer(baking_delay_ms).timeout
	_baking_begin_time_ms = Time.get_ticks_msec()
	_navigation_region_3d.bake_finished.connect(_on_bake_finished)
	_navigation_region_3d.bake_navigation_mesh()
	print("baking started")


func _on_bake_finished():
	var baking_end_time_ms = Time.get_ticks_msec()
	print('baking finished, took {0} [ms]'.format([baking_end_time_ms - _baking_begin_time_ms]))
