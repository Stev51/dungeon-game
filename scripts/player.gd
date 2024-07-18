extends CharacterBody2D

const SPEED = 300.0

var vel = Vector2.ZERO
var can_shoot = true

func _physics_process(delta):
	move_player()
	spawn_arrows()

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

func spawn_arrows():
	if Input.is_action_just_pressed("arrow"):
		if can_shoot and Global.attacking == false and get_parent() != null:
			get_parent().add_child(Global.new_arrow(position, rotation, 0))
			can_shoot = false
			$ArrowCooldown.start()

func _on_arrow_cooldown_timeout():
	can_shoot = true
