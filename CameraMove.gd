extends Camera2D
var MousePos = Vector2(0, 0)
var oldMousePos = Vector2(0, 0)
var Speed = Vector2(0, 0)
func _process(delta):
	MousePos = get_viewport().get_mouse_position()
	Speed = Vector2(MousePos - oldMousePos)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		translate(-Speed)
	oldMousePos = get_viewport().get_mouse_position()
