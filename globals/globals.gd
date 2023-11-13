extends Node

signal stat_changed

var last_hi_score: int = get_highest_score()
var hi_score: int = last_hi_score
var collision_multiplier: int = 0
var collected: int = 0

var score: int = 0:
	set(value):
		score = max(value, 0)
		if score >= last_hi_score:
			hi_score = score
		else:
			hi_score = last_hi_score
		stat_changed.emit()


var time_left: int = 0:
	set(value):
		time_left = value
		stat_changed.emit()


func read_hi_scores():
	var file = FileAccess.open("res://globals/hi_scores.json", FileAccess.READ)
	var content: String = file.get_as_text()
	var dict = JSON.parse_string(content)
	return dict["hi_scores"]


func get_highest_score():
	var scores = read_hi_scores()
	var highest_score = 0
	for recorded_score in scores:
		if recorded_score["score"] > highest_score:
			highest_score = recorded_score["score"]
	return highest_score


func update_hi_score():
	var scores = read_hi_scores()
	for i in range(3):
		pass
