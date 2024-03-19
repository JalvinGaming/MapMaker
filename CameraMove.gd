extends Camera2D
var MousePos = Vector2(0, 0)
var oldMousePos = Vector2(0, 0)
var ZoomIn = 0.5
var ZoomOut = 0.5
var Speed = Vector2(0, 0)
func _process(delta):
	MousePos = get_viewport().get_mouse_position()
	Speed = Vector2(MousePos - oldMousePos)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) or Input.is_action_pressed("moveable"):
		translate(-Speed / zoom)
	oldMousePos = get_viewport().get_mouse_position()
	if Input.is_action_pressed("zoomin"):
		zoom += Vector2(ZoomIn, ZoomIn) * zoom * delta
	if Input.is_action_pressed("zoomout"):
		zoom -= Vector2(ZoomOut, ZoomOut) * zoom * delta
