extends Node

onready var desktop = get_parent().get_node('desktop')
onready var task_bar = get_parent().get_node('desktop/task_bar_container')
var icon : PackedScene = preload('res://icon.tscn')
var window_is_open = true
var bye = false

func _ready():
	var icon_inst = icon.instance()
	task_bar.add_child(icon_inst)
	icon_inst.dad(self)
	icon_inst.icon_name('computer')

func go():
	window_is_open = true

func stop():
	window_is_open = false

func _on_exit_pressed():
	desktop.go()
	bye = true
	queue_free()

func _on_minimize_pressed():
	self.visible = false
	desktop.go()
