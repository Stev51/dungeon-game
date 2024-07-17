extends CharacterBody2D

const SPEED = 300.0
const MARGIN = 25

var vel = Vector2.ZERO
var close_edge = Vector2(MARGIN, MARGIN)
var far_edge

func _ready():
	far_edge = get_viewport_rect().size - close_edge

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
	position = position.clamp(close_edge, far_edge)
