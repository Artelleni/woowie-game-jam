extends Node2D

export var newLevel = "res://Content/Platformer/Levels/Level1.tscn"

export var active = true

func _on_Area2D_body_entered(body):
	if active and body.name == "Character":
		get_tree().change_scene(newLevel)
