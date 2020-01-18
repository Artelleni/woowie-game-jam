extends Button

var icon_name : String = ''
onready var desktop = get_parent().get_parent()
var dad 

func icon_name(name1):
	icon_name = name1

func _physics_process(delta):
	self.text = icon_name
	
	if dad.bye == true:
		queue_free()

func _on_computer_icon_pressed():
	if desktop.window_is_open == true:
		desktop.stop()
		dad.visible = true

func dad(me):
	dad = me