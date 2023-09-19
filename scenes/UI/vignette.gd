extends CanvasLayer


func _ready():
	GameEvents.player_get_damage.connect(on_player_get_damage)


func on_player_get_damage():
	$AnimationPlayer.play("hit")
