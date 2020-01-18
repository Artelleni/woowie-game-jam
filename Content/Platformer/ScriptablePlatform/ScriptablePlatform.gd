extends "res://Content/ScriptableObject/ScriptableObject.gd"



func _on_ScpritablePlatform_start_glitch():
	print("signal")
	$StaticBody2D.collision_layer = 10
	$StaticBody2D.collision_mask = 10


func _on_ScpritablePlatform_end_glitch():
	print("signal")
	$StaticBody2D.collision_layer = 1
	$StaticBody2D.collision_mask = 1
