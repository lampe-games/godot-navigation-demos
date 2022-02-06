extends Spatial

const SmallAgent = preload("res://3d/SmallAgent.tscn")


func _ready():
	var agents_container = find_node("Agents")
	var spot_1 = find_node("Spot")
	var spot_2 = find_node("Spot2")
	var agent_1 = SmallAgent.instance()
	var agent_2 = SmallAgent.instance()
	agent_1.transform.origin = Vector3(-999, 0, -999)
	agent_2.transform.origin = Vector3(-999, 0, -999)
	agent_1.distance_to_go = 0.0
	agent_2.distance_to_go = 0.0
	agents_container.add_child(agent_1)
	agents_container.add_child(agent_2)
	agent_1.hide()
	agent_2.hide()
	yield(get_tree().create_timer(2.0), "timeout")
	var nmi = find_node("NavigationMeshInstance")
	nmi.bake_navigation_mesh()
	yield(nmi, "bake_finished")
	agent_1.global_transform = spot_1.global_transform
	agent_2.global_transform = spot_2.global_transform
	agent_1.show()
	agent_2.show()
	agent_1.move_forward(10.0)
	agent_2.move_forward(10.0)
