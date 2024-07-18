extends Area2D

const SPEED = 600.0

var velocity
var flying = true

func _ready():
	velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	$Line2D.global_rotation_degrees = 0
	if flying:
		position += velocity * SPEED * delta

func _on_body_entered(body):
	if body.is_in_group("colliders"):
		flying = false

func _on_area_exited(area):
	if area.is_in_group("screen"):
		queue_free()
