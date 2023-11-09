extends CharacterBody2D

var speed: int = 200
var direction: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()


var collision_detectors = {
	Vector2.LEFT: "CollisionDetectors/W",
	Vector2.RIGHT: "CollisionDetectors/E",
	Vector2.DOWN: "CollisionDetectors/S",
	Vector2.UP: "CollisionDetectors/N",
}


func _ready():
	direction = pick_random_direction()
	set_change_direction_timer()


func _process(_delta):
	var collision_detector = get_node(collision_detectors[direction]) as Node2D
	if !can_go(collision_detector.get_children()):
		direction = pick_random_direction()
	
	velocity = direction * speed
	move_and_slide()


func can_go(rays:Array[Node]) -> bool:
	var possible: bool = true
	for ray in rays:
		possible = possible and !(ray as RayCast2D).is_colliding()
	return possible


func pick_random_direction():
	var possible_directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	return possible_directions.pick_random()


func _on_change_direction_timer_timeout():
	print('change direction!')
	direction = pick_random_direction()
	set_change_direction_timer()


func set_change_direction_timer():
	$ChangeDirectionTimer.wait_time = rng.randi_range(5, 15)
	$ChangeDirectionTimer.start()
