extends KinematicBody2D


const UP = Vector2(0, -1)
var motion = Vector2()

export var maxVelocity = 400
export var xAcceleration = 50
export var gravity = 40
export var wallFriction = 35
export var jumpForce = 600
export var nJumps = 1
export var dashSpeed = 1000
export var xFriction = 100
export var canGrab = false

var iniPos = Vector2(0, 0)

var jumps = 0
var isDashing = false
var dashDeceleration = 70

var console = null

func _ready():
	var consoles = get_tree().get_nodes_in_group("Console")
	console = consoles[0]
	add_to_group("Character")
	iniPos = position


func kill():
	position = iniPos

func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return "left"
		elif collision.normal.x < 0:
			return "right"
	return "none"

func _process(delta):
	var dir = 0
	var f = 0
	
	if is_on_floor():
		motion.y -= 0
		jumps = 0
	else:
		if canGrab and is_on_wall() and motion.y > 0:
			if Input.is_action_just_pressed("ui_up") and not console.writing:
				var collision = get_which_wall_collided()
				
				motion.y = -jumpForce
				
				if collision == "right":
					motion.x = -jumpForce
				elif collision == "left":
					motion.x = jumpForce

			motion.y += gravity - wallFriction
			jumps = 1
		else:
			motion.y += gravity
	
	
	if Input.is_action_just_pressed("ui_up") and jumps < nJumps and not console.writing:
		motion.y = -jumpForce
		jumps += 1
	
	if (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left")) or (not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left")):
		f = abs(motion.x)
		if f > 0:
			dir = motion.x / abs(motion.x)
			motion.x = dir * min(f - xFriction, 0)
	else:
		if not console.writing:
			if Input.is_action_pressed("ui_right"):
				motion.x += xAcceleration
				
			elif Input.is_action_pressed("ui_left"):
				motion.x -= xAcceleration


	if abs(motion.x) > 0:
		f = abs(motion.x)
		dir = motion.x / f
		
		
		if Input.is_action_just_pressed("ui_shift") and not isDashing and not console.writing:
			motion.x = dashSpeed * dir
			isDashing = true
		elif isDashing:
			motion.x -= dashDeceleration * dir
			if abs(motion.x) < maxVelocity:
				isDashing = false
		else:
			motion.x = dir * min(abs(motion.x), maxVelocity)
			
	
	motion = move_and_slide(motion, UP)
