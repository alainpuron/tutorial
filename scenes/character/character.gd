extends CharacterBody2D # the script can use the properties of


@export var animation: AnimatedSprite2D
@export var area_2d: Area2D
@export var character_red_material: ShaderMaterial

var _velocity: float = 100.0
var _jump_velocity: float = -300.0
var _dead: bool = false

#	func _process(delta):
	# position.x += 1 -- Character would move depending on the PC's power
		#position.x += 10 * delta # character moves 1 frame per second


func _ready():
	area_2d.body_entered.connect(_on_area_2d_body_entered)
	
	
	
# Runs 60 times per second 
func _physics_process(delta):
	if _dead:
		return
	
	
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	animation.material = character_red_material # or animation.module = Color.(18.892,0.0,0.0,1.0)
	_dead = true
	animation.stop()
