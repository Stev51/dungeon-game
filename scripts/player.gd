extends CharacterBody2D

const SPEED = 300.0

var vel = Vector2.ZERO

func _physics_process(delta):
	move_player()

func move_player():
	
	vel = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
	
	velocity = vel.normalized() * SPEED
	
	if vel.length() > 0:
		rotation = velocity.angle()
	
	move_and_slide()
