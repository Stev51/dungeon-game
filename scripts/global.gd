extends Node

var attacking = false

func new_arrow(pos, rot, shot):
	
	var arrow = preload("res://scenes/arrow.tscn").instantiate()
	
	arrow.position = pos
	arrow.rotation = rot
	arrow.shooter = shot
	
	return arrow
