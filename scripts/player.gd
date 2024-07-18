extends CharacterBody2D

const SPEED = 300.0
const HOOK_SPEED = 300.0

var tree
var vel = Vector2.ZERO
var hook_vel = Vector2.ZERO
var can_shoot = true
var hooks
var diff

func _ready():
	tree = get_tree()
	$Camera2D.set_as_top_level(true)

func _physics_process(delta):
	move_player()
	spawn_arrows()
	spawn_hooks()
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
	
	hook_vel = Vector2.ZERO
	hooks = tree.get_nodes_in_group("hooks")
	for hook in hooks:
		if Input.is_action_just_pressed("release_hooks"):
			hook.queue_free()
		else:
			diff = position - hook.position
			hook.get_node("Line2D").set_point_position(1, diff)
			hook_vel -= diff.normalized()
	
	velocity = (vel.normalized() * SPEED) + (hook_vel * SPEED)
	
	if vel.length() > 0:
		rotation = vel.angle()
	
	move_and_slide()

func spawn_arrows():
	if Input.is_action_just_pressed("arrow"):
		if can_shoot and Global.attacking == false and get_parent() != null:
			get_parent().add_child(Global.new_arrow(position, rotation, 0))
			can_shoot = false
			$ArrowCooldown.start()

func spawn_hooks():
	if Input.is_action_just_pressed("hook"):
		if get_parent() != null:
			get_parent().add_child(Global.new_hook(position, rotation))

func screen_update():
	
	var screen = (global_position / Global.SCREEN_SIZE).floor()
	if not screen.is_equal_approx(Global.current_screen):
		
		Global.current_screen = screen
		Global.current_screen_pos = screen * Global.SCREEN_SIZE + Global.SCREEN_SIZE * 0.5
		
		$Camera2D.global_position = Global.current_screen_pos

func _on_arrow_cooldown_timeout():
	can_shoot = true
