extends Node2D

var waiting: bool = true

func _process(_delta):
	if Input.is_action_pressed("confirm") and waiting:
		waiting = false
		$AudioStreamPlayer.play()
		TransitionLayer.change_scene("res://scenes/user_interface/instructions_screen.tscn")
