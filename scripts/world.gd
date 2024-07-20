extends Node2D

var tree

func _ready():
	tree = get_tree()

func _process(delta):
	
	$CurrentScreen.position = Global.current_screen_pos
	
	if Global.over_chasm:
		if tree.get_nodes_in_group("connected").size() <= 0:
			$Player.respawn()
	
	if Input.is_action_just_pressed("debug"):
		print("--- DEBUG ---")
		print("over_chasm: ", Global.over_chasm)
		print("can_move: ", Global.can_move)
		print("HookContainer children: ", $HookContainer.get_children().size())

func checkpoint(area):
	$Player.respawn_pos = area.position
	print("set checkpoint to ", area.name)

func _on_chasm_area_body_entered(body):
	if body.is_in_group("player"):
		Global.over_chasm = true
		Global.can_move = false

func _on_chasm_area_body_exited(body):
	if body.is_in_group("player"):
		Global.over_chasm = false
		Global.can_move = true

func _on_checkpoint_1_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoint1)

func _on_checkpoint_2_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoint2)

func _on_checkpoint_3_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoint3)

func _on_checkpoint_4_body_entered(body):
	if body.is_in_group("player"):
		checkpoint($Checkpoint4)
