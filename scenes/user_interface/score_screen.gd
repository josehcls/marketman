extends Node2D

var waiting: bool = true

@onready var collected_label: Label = $Control/VBoxContainer/Collected/Value
@onready var shoppers_label: Label = $Control/VBoxContainer/Shoppers/Value
@onready var time_left_label: Label = $Control/VBoxContainer/TimeLeft/Value
@onready var score_label: Label = $Control/VBoxContainer/FinalScoreValue


func _ready():
	collected_label.text = str(Globals.collected * 100)
	shoppers_label.text = str(Globals.collision_multiplier * -150)
	time_left_label.text = str(Globals.time_left * 50)
	score_label.text = str(Globals.score)


func _process(_delta):
	if Input.is_action_pressed("confirm") and waiting:
		waiting = false
		$AudioStreamPlayer.play()
		TransitionLayer.change_scene("res://scenes/user_interface/title_screen.tscn")
