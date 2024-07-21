extends Node2D

var tree
var chasm_disabled

func _ready():
	tree = get_tree()

func _process(delta):
	
	$CurrentScreen.position = Global.current_screen_pos
	
	if Global.over_chasm:
		if tree.get_nodes_in_group("connected").size() <= 0:
			$Player.respawn()
	
	if Input.is_action_just_pressed("debug"):
		print("--- DEBUG ---")
		print("can_move: ", Global.can_move)
		print("attacking: ", Global.attacking)
		print("over_chasm: ", Global.over_chasm)
		print("chasm_disabled: ", chasm_disabled)

func chasm_disable():
	if not chasm_disabled:
		chasm_disabled = true
		for poly in $ChasmCollision.get_children():
			poly.set_deferred("disabled", true)
			#poly.get_node("Sprite2D").visible = false

func chasm_enable():
	if tree.get_nodes_in_group("connected").size() <= 0:
		chasm_disabled = false
		for poly in $ChasmCollision.get_children():
			poly.set_deferred("disabled", false)
			#poly.get_node("Sprite2D").visible = true

func checkpoint(area):
	$Player.respawn_pos = area.position

func _on_chasm_area_body_entered(body):
	if body.is_in_group("player"):
		Global.over_chasm = true
		Global.can_move = false

func _on_chasm_area_body_exited(body):
	if body.is_in_group("player"):
		Global.over_chasm = false
		Global.can_move = true

# Maybe find some way to clean this up to be more universal VVV

func _on_checkpoint_1_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoints/Checkpoint1)

func _on_checkpoint_2_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoints/Checkpoint2)

func _on_checkpoint_3_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoints/Checkpoint3)

func _on_checkpoint_4_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoints/Checkpoint4)
