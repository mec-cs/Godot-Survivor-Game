extends Node

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: Node
@export var vail_scene: PackedScene


func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died():
	var adjusted_drop_percent = drop_percent
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += 0.15
	
	if randf() > adjusted_drop_percent:
		return
	
	if vail_scene == null:
		return
		
	if not owner is Node2D:
		return
		
	var spawn_position = (owner as Node2D).global_position
	var vail_instance = vail_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(vail_instance)
	vail_instance.global_position = spawn_position
