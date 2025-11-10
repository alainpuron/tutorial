extends CharacterBody2D # the script can use the properties of


@export var animation: AnimatedSprite2D

var _velocity: float = 100.0
var _jump_velocity: float = -300.0

#	func _process(delta):
	# position.x += 1 -- Character would move depending on the PC's power
		#position.x += 10 * delta # character moves 1 frame per second

# Runs 60 times per second 
func _physics_process(delta):
	
	
	
	#gravity
	velocity += get_gravity() * delta # return the gravity value
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += _jump_velocity
		
	# movement 
	if Input.is_action_pressed("right"):
		velocity.x = _velocity
		animation.flip_h = true
	elif Input.is_action_pressed("left"):
		velocity.x =-_velocity
		animation.flip_h = false

	else:
		velocity.x = 0
	move_and_slide()
	
	# Animation
	if !is_on_floor():
		animation.play("jumping")
	elif velocity.x !=0:
		animation.play("running")
	else:
		animation.play("idle")
