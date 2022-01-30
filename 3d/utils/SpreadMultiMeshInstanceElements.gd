extends MultiMeshInstance


func _ready():
	for i in range(multimesh.instance_count):
		multimesh.set_instance_transform(i, Transform(Basis(), Vector3(-5 * i, 0, 0)))
