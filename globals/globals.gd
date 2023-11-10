extends Node

signal stat_changed

var last_hi_score: int = 50
var hi_score: int = last_hi_score

var score: int = 0:
	set(value):
		score = value
		
		if score >= last_hi_score:
			hi_score = score
		else:
			hi_score = last_hi_score
			
		stat_changed.emit()

var time_left: int = 999:
	set(value):
		time_left = value
		stat_changed.emit()
