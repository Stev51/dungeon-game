extends Area2D
class_name Arrow

const SPEED = 600.0

var shooter
var velocity
var flying = true

func _ready():
	velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	if flying:
		position += velocity * SPEED * delta

func _on_despawn_collision_body_entered(body):
	if body.is_in_group("colliders"):
		flying = false

func _on_body_entered(body):
	if flying:
		pass #do dmg (this if statement disables non-flying arrows from damaging)
