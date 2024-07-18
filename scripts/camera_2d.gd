extends Camera2D

const SCREEN_SIZE = Vector2(800, 600)

var current_screen = Vector2.ZERO

func _ready():
	set_as_top_level(true)
	update_screen(current_screen)

func _physics_process(delta):
	var parent_screen = (get_parent().global_position / SCREEN_SIZE).floor()
	if not parent_screen.is_equal_approx(current_screen):
		update_screen(parent_screen)

func update_screen(new_screen):
	current_screen = new_screen
	global_position = current_screen * SCREEN_SIZE + SCREEN_SIZE * 0.5
