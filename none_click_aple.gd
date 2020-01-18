extends Button

onready var select = get_parent().get_node('desktop/select')

func _on_none_click_aple_pressed():
	select.position.x = 10000
	select.position.y = 10000
