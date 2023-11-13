extends Area2D

var angle_rad: float = 0.0 
signal player_exited_level

func _process(delta):
	angle_rad += delta
	global_position.y += sin(angle_rad * 2) / 20


func _on_player_exited_level():
	player_exited_level.emit()

