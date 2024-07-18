extends CharacterBody2D

const SPEED = 300.0

var vel = Vector2.ZERO
var can_shoot = true

func _ready():
	$Camera2D.set_as_top_level(true)

func _physics_process(delta):
	move_player()
	spawn_arrows()
	screen_update()

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

func screen_update():
	
	var screen = (global_position / Global.SCREEN_SIZE).floor()
	if not screen.is_equal_approx(Global.current_screen):
		
		Global.current_screen = screen
		Global.current_screen_pos = screen * Global.SCREEN_SIZE + Global.SCREEN_SIZE * 0.5
		
		$Camera2D.global_position = Global.current_screen_pos

func _on_arrow_cooldown_timeout():
	can_shoot = true
