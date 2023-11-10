extends CharacterBody2D

var base_speed: int = 200
var speed_multiplier: float = 1.0
var direction: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var can_collide: bool = true

signal player_collision

var collision_detectors = {
	Vector2.LEFT: "CollisionDetectors/W",
	Vector2.RIGHT: "CollisionDetectors/E",
	Vector2.DOWN: "CollisionDetectors/S",
	Vector2.UP: "CollisionDetectors/N",
}


func _ready():
	direction = pick_random_direction()


func _process(_delta):
	var speed = base_speed * speed_multiplier
	
	var collision_detector = get_node(collision_detectors[direction]) as Node2D
	if !can_go(collision_detector.get_children()):
		direction = pick_random_direction()
	
	var possible_directions = get_possible_directions()
	if len(possible_directions) >= 3:
		var new_direction = possible_directions.pick_random()
		if new_direction != (direction * -1):
			direction = new_direction
	
	velocity = direction * speed
	var collision = move_and_slide()
	
	if collision and can_collide:
		can_collide = false
		$ImmunityTimer.start()
		direction *= -1
		speed_multiplier = 1.5


func can_go(rays:Array[Node]) -> bool:
	var possible: bool = true
	for ray in rays:
		possible = possible and !(ray as RayCast2D).is_colliding()
	return possible


func pick_random_direction():
	var possible_directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	return possible_directions.pick_random()


func get_possible_directions():
	var possible_directions = []
	for dir in collision_detectors:
		var collision_detector = get_node(collision_detectors[dir]) as Node2D
		if can_go(collision_detector.get_children()):
			possible_directions.append(dir)
	return possible_directions


func _on_immunity_timer_timeout():
	can_collide = true
	speed_multiplier = 1.0
