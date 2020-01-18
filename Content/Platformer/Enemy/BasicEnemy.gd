extends KinematicBody2D



const UP = Vector2(0, -1)
const gravity = 0.1

var motion = Vector2(0, 0)

var direction = 1
export var velocity = 2

func _ready():
	$GlitchableObject/GlitchArea2D.add_to_group("enemies")
	$GlitchableObject.excludedGroups = ["enemies"]

func _physics_process(delta):
	if not $GlitchableObject.glitch:
		if is_on_floor():
			motion.y = 0
		else:
			motion.y += gravity
			
		motion.x = direction * velocity
		
		motion = move_and_slide(motion, UP)
		
		if abs(motion.x) == 0:
			direction *= -1
	
		position = position + motion
	else:
		if randf() > $GlitchableObject.GLITCH_RATE:
			visible = true
		else:
			visible = false

func _on_BasicEnemy_start_glitch():
	pass # Replace with function body.


func _on_BasicEnemy_end_glitch():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if not $GlitchableObject.glitch and body.is_in_group("Character"):
		body.kill()


