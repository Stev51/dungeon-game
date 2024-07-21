extends CharacterBody2D

@export var resource : Resource

var health = 1

func _ready():
	
	if resource != null:
		$Sprite2D.texture = resource.texture
		health = resource.health

func _physics_process(delta):
	
	pass
	#move_and_slide()
