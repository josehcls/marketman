extends CharacterBody2D

var base_speed: int = 200
@export var speed_multiplier: float = 1.0
var direction: Vector2 = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var can_collide: bool = true
var can_change_direction: bool = true

@export var sprite_variation: int = 0

var sprites = {
	0: preload("res://graphics/characters/MarketSet_Customer1.png"),
	1: preload("res://graphics/characters/MarketSet_Customer2.png"),
	2: preload("res://graphics/characters/MarketSet_Customer3.png"),
	3: preload("res://graphics/characters/MarketSet_Customer4.png")
}

signal player_collision

var collision_detectors = {
	Vector2.LEFT: {"detectors": "CollisionDetectors/W", "animation": "left"},
	Vector2.RIGHT: {"detectors": "CollisionDetectors/E", "animation": "right"},
	Vector2.DOWN: {"detectors": "CollisionDetectors/S", "animation": "down"},
	Vector2.UP: {"detectors": "CollisionDetectors/N", "animation": "up"},
}


func _ready():
	$Sprite2D.set_texture(sprites[sprite_variation])
	direction = pick_random_direction()
	speed_multiplier = 1.0


func _process(_delta):
	var speed = base_speed * speed_multiplier
	
	var collision_detector = get_node(collision_detectors[direction]["detectors"]) as Node2D
	if !can_go(collision_detector.get_children()):
		direction = pick_random_direction()
	
	var possible_directions = get_possible_directions()
	if len(possible_directions) >= 3 and can_change_direction:
		can_change_direction = false
		$ChangeDirectionTimer.start()
		var new_direction = possible_directions.pick_random()
		if new_direction != (direction * -1):
			direction = new_direction
	
	$AnimationPlayer.play(collision_detectors[direction]["animation"])
	velocity = direction * speed
	var collision = move_and_slide()
	
	if collision and can_collide:
		can_collide = false
		$ImmunityTimer.start()
		direction *= -1
		speed_multiplier = 1.5
		player_collision.emit()


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
		var collision_detector = get_node(collision_detectors[dir]["detectors"]) as Node2D
		if can_go(collision_detector.get_children()):
			possible_directions.append(dir)
	return possible_directions


func _on_immunity_timer_timeout():
	can_collide = true
	speed_multiplier = 1.0
	$ImmunityTimer.start()


func _on_change_direction_timer_timeout():
	can_change_direction = true
