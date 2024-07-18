extends Area2D
class_name Arrow

const SPEED = 600.0

var shooter
var velocity

func _ready():
	velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	position += velocity * SPEED * delta
