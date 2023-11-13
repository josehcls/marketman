extends Node2D

var clock_running: bool = true

func _ready():
	$Player.speed_multiplier = 1.0
	for entity in get_tree().get_nodes_in_group("Shoppers"):
		entity.connect("player_collision", _on_player_collision)
	Globals.collision_multiplier = 0
	Globals.time_left = 50
	Globals.score = 0
	Globals.collected = 0


func _on_second_counter_timeout():
	if clock_running:
		Globals.time_left -= 1
		if Globals.time_left == 15:
			$TimeAlertSound.play()
		if Globals.time_left == 0:
			$TimeOutSound.play()
			exit_to_score_screen()


func _on_player_collision():
	$Player.collided()


func _on_exit_player_exited_level():
	$PlayerExitedSound.play()
	exit_to_score_screen()


func exit_to_score_screen():
	var tween = get_tree().create_tween()
	tween.tween_property($Player, "speed_multiplier", 0, 0.2)
	clock_running = false
	for entity in get_tree().get_nodes_in_group("Shoppers"):
		entity.speed_multiplier = 0.0
	Globals.score += Globals.time_left * 50
	TransitionLayer.change_scene("res://scenes/user_interface/score_screen.tscn")
