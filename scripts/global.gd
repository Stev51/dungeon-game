extends Node

const SCREEN_SIZE = Vector2(800, 600)

var current_screen = SCREEN_SIZE * 0.5
var current_screen_pos = current_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
var attacking = false

func new_arrow(pos, rot, shot):
	
	var arrow = preload("res://scenes/arrow.tscn").instantiate()
	
	arrow.position = pos
	arrow.rotation = rot
	arrow.shooter = shot
	
	return arrow

func new_hook(pos, rot):
	
	var hook = preload("res://scenes/hook.tscn").instantiate()
	
	hook.position = pos
	hook.rotation = rot
	
	return hook
