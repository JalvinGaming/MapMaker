extends Node2D
var Mode = 0
var SelectedPath
var SelectedPoly
var SelectedArea
var SelectedNode
var SelectedType
var SelectedCol
var CursorCol
var IsHolding = false
var trueMousePos = Vector2(0, 0)

func _ready():
	CursorCol = get_node("Area2D")

func _process(delta):
	trueMousePos = get_node("Camera2D").MousePos + get_node("Camera2D").position + get_viewport_rect().size * -0.5
	#Create Lines
	if Mode == 1 and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not IsHolding:
		var newbody = Area2D.new()
		add_child(newbody)
		var newpath = Line2D.new()
		SelectedArea = newbody
		SelectedArea.add_child(newpath)
		SelectedPath = newpath
		SelectedPath.add_point(trueMousePos)
		var newcol = CollisionPolygon2D.new()
		SelectedArea.add_child(newcol)
		SelectedCol = newcol
		SelectedCol.polygon = [SelectedPath.points[0]]
		SelectedCol.one_way_collision_margin = 20
		#set styles
		if true:
			#set road style
			if SelectedType == "RoadStandard1Lane":
				SelectedPath.width = 8
				SelectedPath.texture = load("res://Graphics/Lines/Roads/Standard 1 Lane/image.png")
				SelectedPath.z_index = 1
				SelectedPath.texture_mode = Line2D.LINE_TEXTURE_STRETCH
				SelectedPath.texture_repeat = CanvasItem.TEXTURE_REPEAT_DISABLED
			#set default style
			else:
				SelectedPath.z_index = 1
		
		#Create poly
		var newpoly = Polygon2D.new()
		SelectedArea.add_child(newpoly)
		SelectedPoly = newpoly
		
		#set styles
		if true:
			#set road style
			if SelectedType == "RoadStandard1Lane":
				SelectedPoly.color = Color(0, 0, 0, 0)
			#set default style
			else:
				SelectedPoly.color = Color(1, 1, 1, 0.5)
				SelectedPoly.z_index = -1
		
		#Create node
		var newnode = Sprite2D.new()
		newnode.texture = load("res://Graphics/Aids/Node.svg")
		newnode.scale = Vector2(0.1, 0.1)
		newnode.centered = true
		newnode.position = trueMousePos
		SelectedArea.add_child(newnode)
		SelectedNode = newnode
		IsHolding = true
	#Extend Lines
	if Mode == 0 and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not IsHolding and SelectedPath != null:
		SelectedPath.add_point(trueMousePos)
		SelectedPoly.polygon = SelectedPath.points
		SelectedCol.polygon.append(SelectedPath.points[SelectedPath.points.size() - 1])
		if SelectedNode != null:
			SelectedNode.queue_free()
		IsHolding = true
	#Select Lines
	if Mode == 2 and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not IsHolding:
		IsHolding = true
		if CursorCol.get_overlapping_bodies().size() != 0:
			SelectedArea = CursorCol.get_overlapping_bodies()[0]
			SelectedPath = SelectedArea.get_child(0)
			SelectedCol = SelectedArea.get_child(1)
			SelectedPoly = SelectedArea.get_child(2)
			if SelectedArea.get_child(2) != null:
				SelectedNode = SelectedArea.get_child(3)
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		IsHolding = false
#Handle Buttons
func _mode0_button():
	Mode = 0
	IsHolding = true
func _mode1_button():
	Mode = 1
	IsHolding = true
func _mode2_button():
	Mode = 2
	IsHolding = true


func _on_type_change():
	SelectedType = get_node("CanvasLayer/Control/TextEdit").get_text()
