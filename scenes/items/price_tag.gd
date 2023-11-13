extends Area2D

var angle_rad: float = 0.0 

func _process(delta):
	angle_rad += delta
	global_position.y += sin(angle_rad * 2) / 20


func _on_body_entered(_body):
	Globals.score += 100
	Globals.collected += 1
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
