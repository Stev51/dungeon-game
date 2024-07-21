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
	if tile_pos == null:
		print("WARNING: UNDEFINED SWITCH LINK")
	$TileMap.set_cell(3, tile_pos, 5, Vector2i(0,1))
	switch.queue_free()

func door_process(door, tile_pos, new_tile):
	if tile_pos == null or new_tile == null:
		print("WARNING: UNDEFINED DOOR LINK")
	$TileMap.set_cell(2, tile_pos, 4, new_tile)
	door.queue_free()

func incr_boss_switches():
	boss_switches += 1
	if boss_switches >= 4:
		door_process($DoorCollisions/Doors3, Vector2i(24,-11), Vector2i(5,0))

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
		switch_process($Switches/Switch1, Vector2i(8,6))
		incr_boss_switches()

func _on_switch_2_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch2, Vector2i(8,-18))
		incr_boss_switches()

func _on_switch_3_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch3, Vector2i(56,-18))
		incr_boss_switches()

func _on_switch_4_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch4, Vector2i(56,6))
		door_process($DoorCollisions/Doors4, Vector2i(56,-1), Vector2i(5,4))
		door_process($DoorCollisions/Doors5, Vector2i(56,1), Vector2i(5,0))
		incr_boss_switches()

func _on_switch_5_area_entered(area):
	if area.is_in_group("sword") and Global.attacking:
		switch_process($Switches/Switch5, Vector2i(56,-6))
		door_process($DoorCollisions/Doors2, Vector2i(8,-11), Vector2i(5,0))

func _on_arrow_switch_1_area_entered(area):
	if area.is_in_group("arrows"):
		area.queue_free()
		switch_process($Switches/ArrowSwitch1, Vector2i(40,1))
		door_process($DoorCollisions/Doors7, Vector2i(47,6), Vector2i(8,1))
