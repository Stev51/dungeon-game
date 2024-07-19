extends Node2D

func _process(delta):
	
	$CurrentScreen.position = Global.current_screen_pos
	
	if Global.can_move and Global.over_chasm:
		$Player.respawn()

func checkpoint(area):
	$Player.respawn_pos = area.position

func _on_chasm_area_body_entered(body):
	if body.is_in_group("player"):
		Global.over_chasm = true
		Global.can_move = false

func _on_chasm_area_body_exited(body):
	if body.is_in_group("player"):
		Global.over_chasm = true
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
