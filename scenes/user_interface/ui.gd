extends CanvasLayer

@onready var score_counter: Label = $ScoreCounter/Score
@onready var hi_score_counter: Label = $HiScoreCounter/Score
@onready var time_counter: Label = $TimeCounter/Time

func _ready():
	Globals.connect("stat_changed", update_stats)
	update_stats()

func update_stats():
	update_score()
	update_hi_score()
	update_time()

func update_score():
	score_counter.text = str(Globals.score)

func update_hi_score():
	hi_score_counter.text = str(Globals.hi_score)

func update_time():
	time_counter.text = str(Globals.time_left)
