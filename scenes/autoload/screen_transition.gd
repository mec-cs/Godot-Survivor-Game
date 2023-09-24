extends CanvasLayer

signal transitioned_halfway


func transition():
	transition_in()


func transition_in():
	$ColorRect.visible = true
	$AnimationPlayer.play("default")
	await $AnimationPlayer.animation_finished
	transitioned_halfway.emit()
	transition_out()


func transition_out():
	$AnimationPlayer.play_backwards("default")
	await $AnimationPlayer.animation_finished
	$ColorRect.visible = false
