extends Node2D


# This are the objects that can glitch
# It is a simple behavior that "deactivates" the object.
# For that, the start_glitch and end_glitch signals must
# be handled

export var glitch = false

export var excludedGroups = [""]

const GLITCH_RATE = 0.5
var glitchingAreas = 0

signal start_glitch
signal end_glitch


# Checks if the glitch is active from the begining
func _ready():
	if glitch:
		emit_signal("start_glitch")
	
	# The basic behaviour is gen two glitchable objects suddenly collides
	$GlitchArea2D.add_to_group("Glitch_Area")
	


# Function that activates the glitch
func glitch(time=-1):
	print ("glitch")
	glitch = true
	emit_signal("start_glitch")
	
	if time > 0:
		$GlitchTimer.wait_time = time
		$GlitchTimer.start()
		

# Deactivates the glitch
func unGlitch():
	print ("unglitch")
	glitch = false
	visible = true
	emit_signal("end_glitch")


func _process(delta):
	# Makes the glitch animation
	if glitch:
		if randf() > GLITCH_RATE:
			visible = true
		else:
			visible = false


func _on_GlitchTimer_timeout():
	unGlitch()


# Checks for overlaping with other glitches
func _on_GlitchArea2D_area_entered(area):
	if area.is_in_group("Glitch_Area"):
		for e in excludedGroups:
			if area.is_in_group(e):
				return
		glitch()
		glitchingAreas = glitchingAreas + 1



# Checks if overlaping stoped
func _on_GlitchArea2D_area_exited(area):
	if area.is_in_group("Glitch_Area"):
		glitchingAreas = glitchingAreas - 1
		if glitchingAreas == 0:
			unGlitch()
		
