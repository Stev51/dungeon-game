extends Area2D

const SPEED = 600.0
const CONNECTOR_SPEED = 900.0

var velocity
var connector_vel
var active = true
var flying = true
var connected = true

func _ready():
	velocity = Vector2(1, 0).rotated(rotation)

func _physics_process(delta):
	
	if Input.is_action_just_pressed("release_hooks") and connected:
		connected = false
	
	if flying:
		position += velocity * SPEED * delta
	
	if active:
		$Line2D.set_point_position(1, $Connector.position)
		if not connected:
			connector_vel = (global_position - $Connector.global_position).normalized()
			$Connector.global_position += connector_vel * CONNECTOR_SPEED * delta

func deactivate():
	active = false
	$Line2D.queue_free()
	$Connector.queue_free()
	print("deactivated")

func _on_body_entered(body):
	if body.is_in_group("walls"):
		flying = false
	elif body.is_in_group("doors"):
		queue_free()

func _on_area_exited(area):
	if area.is_in_group("screen"):
		queue_free()

func _on_despawn_collision_body_entered(body):
	if active:
		if not flying and body.is_in_group("player"):
			deactivate()

func _on_despawn_collision_area_entered(area):
	if active:
		if not connected and area == $Connector:
			deactivate()
