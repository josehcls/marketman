extends Node2D


func _ready():
	for entity in get_tree().get_nodes_in_group("Shoppers"):
		entity.connect("player_collision", _on_player_collision)


func _on_second_counter_timeout():
	Globals.time_left -= 1


func _on_player_collision():
	$Player.collided()
