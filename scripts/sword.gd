extends Area2D

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("attack"):
		if Global.attacking == false:
			$AnimationPlayer.play("attack")
			Global.attacking = true
			visible = true
			$AttackCooldown.start()

func _on_attack_cooldown_timeout():
	Global.attacking = false
	visible = false
