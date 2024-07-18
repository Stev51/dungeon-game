extends Area2D

const SPEED = 600.0

var velocity
var flying = true
var connected = true

func _ready():
	velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	print($Connector.global_position)
	$Line2D.set_point_position(1, $Connector.position)
	if flying:
		position += velocity * SPEED * delta
	elif position.is_equal_approx($Connector.position):
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("colliders"):
		flying = false

func _on_area_exited(area):
	if area.is_in_group("screen"):
		queue_free()
