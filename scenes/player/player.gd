extends CharacterBody2D

var base_speed: int = 300
var speed_multiplier: float = 1.0
var direction: Vector2 = Vector2.ZERO
var next_direction: Vector2 = Vector2.ZERO
var vulnerable: bool = true


func _process(_delta):
	var speed = base_speed * speed_multiplier
	
	if Input.is_action_pressed("left") or next_direction == Vector2.LEFT:
		if can_go($CollisionDetectors/W.get_children()):
			$AnimationPlayer.play("walk_left")
			direction = Vector2.LEFT
			next_direction = Vector2.ZERO
		elif direction != Vector2.LEFT:
			next_direction = Vector2.LEFT
	if Input.is_action_pressed("right") or next_direction == Vector2.RIGHT:
		if can_go($CollisionDetectors/E.get_children()):
			$AnimationPlayer.play("walk_right")
			direction = Vector2.RIGHT
			next_direction = Vector2.ZERO
		else:
			next_direction = Vector2.RIGHT
	if Input.is_action_pressed("down") or next_direction == Vector2.DOWN:
		if can_go($CollisionDetectors/S.get_children()):
			$AnimationPlayer.play("walk_down")
			direction = Vector2.DOWN
			next_direction = Vector2.ZERO
		else:
			next_direction = Vector2.DOWN
	if Input.is_action_pressed("up") or next_direction == Vector2.UP:
		if can_go($CollisionDetectors/N.get_children()):
			$AnimationPlayer.play("walk_up")
			direction = Vector2.UP
			next_direction = Vector2.ZERO
		else:
			next_direction = Vector2.UP
	
	if speed_multiplier == 0:
		$AnimationPlayer.stop()
	
	if direction == Vector2.RIGHT and !can_go($CollisionDetectors/E.get_children()):
		direction = Vector2.ZERO
	elif direction == Vector2.LEFT and !can_go($CollisionDetectors/W.get_children()):
		direction = Vector2.ZERO
	elif direction == Vector2.DOWN and !can_go($CollisionDetectors/S.get_children()):
		direction = Vector2.ZERO
	elif direction == Vector2.UP and !can_go($CollisionDetectors/N.get_children()):
		direction = Vector2.ZERO
	
	velocity = direction * speed
	move_and_slide()


func can_go(rays:Array[Node]) -> bool:
	var possible: bool = true
	for ray in rays:
		possible = possible and !(ray as RayCast2D).is_colliding()
	return possible


func collided():
	if vulnerable:
		vulnerable = false
		speed_multiplier = 0.5
		$ImmunityTimer.start()
		Globals.score -= 150
		Globals.collision_multiplier += 1
		$AudioStreamPlayer2D.play()
		direction *= -1


func _on_immunity_timer_timeout():
	vulnerable = true
	speed_multiplier = 1
