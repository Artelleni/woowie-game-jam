extends Button

export var scene : PackedScene = preload('res://computer.tscn')
var double_click : bool = false
onready var desktop = get_parent().get_parent()

#mouse_double_click:
func _on_computer_pressed():
	if get_parent().get_parent().window_is_open == true:
		if double_click == false:
			desktop.button_select($select_place)
			$double_click.start()
			double_click = true
		else:
			desktop.stop()
			open()



func _on_double_click_timeout():
	double_click = false

#open:
func open():
	var scene_inst = scene.instance()
	get_parent().get_parent().get_parent().add_child(scene_inst)

