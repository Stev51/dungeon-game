extends Node2D

var tree
var boss_switches = 0
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

func switch_process(switch, tile_pos):
	switch.queue_free()

func door_process(door, tile_pos, new_tile):
	door.queue_free()

func incr_boss_switches():
	boss_switches += 1
	if boss_switches >= 4:
		door_process($DoorCollisions/Doors3, null)

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

# Same thing VVV

func _on_switch_1_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch1, null)
		incr_boss_switches()

func _on_switch_2_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch2, null)
		incr_boss_switches()

func _on_switch_3_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch3, null)
		incr_boss_switches()

func _on_switch_4_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch4, null)
		door_process($DoorCollisions/Doors4, null)
		door_process($DoorCollisions/Doors5, null)
		incr_boss_switches()

func _on_switch_5_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch5, null)
		door_process($DoorCollisions/Doors2, null)

func _on_arrow_switch_1_area_entered(area):
	if area.is_in_group("arrows"):
		area.queue_free()
		switch_process($Switches/ArrowSwitch1, null)
		door_process($DoorCollisions/Doors7, null)
