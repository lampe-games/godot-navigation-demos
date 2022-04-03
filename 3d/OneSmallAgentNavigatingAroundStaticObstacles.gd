extends Spatial

const SmallAgent = preload("res://3d/SmallAgent.tscn")


func _ready():
	yield(get_tree().create_timer(0.5), 'timeout')
	var agent = SmallAgent.instance()
	find_node("Placeholder").add_child(agent)
	print(agent.find_node("NavigationAgent").get_nav_path())
	print(agent.find_node("NavigationAgent").get_next_location())
	print(agent.find_node("NavigationAgent").get_nav_path())
