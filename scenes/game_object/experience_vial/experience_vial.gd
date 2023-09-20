extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite_2d = $Sprite2D


func _ready():
	$Area2D.area_entered.connect(on_area_entered)


func tween_collect(percent:float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start = player.global_position - start_position
	
	var target_rotation_degrees = rad_to_deg(direction_from_start.angle() + 90)
	rotation_degrees = lerp(rotation_degrees, target_rotation_degrees, 1 - exp(-2 * get_process_delta_time()))


func collect():
	GameEvents.emit_experience_vial_collected(1)
	queue_free()


func disable_collision():
	collision_shape_2d.disabled = true


func on_area_entered(other_area: Area2D):
	Callable(disable_collision).call_deferred()
	
	var tween = create_tween()
	tween.set_parallel()
	# set easeInBack
	
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK) 
	
	# since there is a time diff of 0.50 and 0.15, add a delay (0.35)
	tween.tween_property(sprite_2d, "scale", Vector2.ZERO, 0.15).set_delay(0.35)
	tween.chain() # wait for all previous tweens to finish before moving on the next tweens
	tween.tween_callback(collect)
	
	$RandomAudioStreamPlayer2DComponent.play_random()
