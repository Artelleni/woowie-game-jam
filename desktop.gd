extends Node

var window_is_open = true

func go():
	window_is_open = true

func stop():
	window_is_open = false

func button_select(pos):
	$select.global_position = pos.global_position

func _on_start_pressed():
	if $exit.visible == false:
		$exit.visible = true
	
	elif $exit.visible == true:
		$exit.visible = false


func _on_exit_pressed():
	get_tree().quit()
