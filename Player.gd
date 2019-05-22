extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 25
const ACCELERATION = 5
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
onready var animate = $AnimatedSprite
# motion/movement
var motion = Vector2()
var on_ground = false

func _physics_process(delta):
	# motion = Vector2()

	# motion = motion.normalized() * 300
	motion.y += GRAVITY
	
	if Input.is_action_pressed('ui_right'):
		if !is_on_floor():
			animate.play('jump')
			animate.flip_h = false
			motion.x = MAX_SPEED
		else:
			motion.x = MAX_SPEED
			animate.flip_h = false
			animate.play('run')
	
	elif Input.is_action_pressed('ui_left'):
		if !is_on_floor():
			animate.play('jump')
			animate.flip_h = true
			motion.x = -MAX_SPEED
		else:
			motion.x = -MAX_SPEED
			animate.play('run')
			animate.flip_h = true
		
	else:
		if !is_on_floor():
			animate.play('jump')
		else:
			animate.play('idle')
			# make the character slide
			motion.x = lerp(motion.x, 0, 0.2)

	
	
	if is_on_floor():
		if Input.is_action_pressed('ui_up'):
			animate.play('jump')
			motion.y = JUMP_HEIGHT
		
	motion = move_and_slide(motion, UP )