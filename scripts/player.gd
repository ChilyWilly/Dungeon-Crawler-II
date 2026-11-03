extends CharacterBody2D


const SPEED = 120.0

var direction_x = 0.0
var direction_y = 0.0
var attack = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)
	

func _on_animation_finished():
	if animated_sprite.animation.begins_with("atk"):
		attack = false


func _physics_process(delta: float) -> void:
	
	movement()
	animations()
	move_and_slide()


func movement():
	# Get the input direction and handle the movement/deceleration.
	direction_x = Input.get_axis("left", "right")
	direction_y = Input.get_axis("up", "down")
		
	var direction = Vector2(direction_x, direction_y).normalized()
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)


func animations():
	# Play idle and movement animations
	if not attack:
		if direction_x == 0 and direction_y == 0:
			animated_sprite.play("idle")
		elif direction_y >= 0 and direction_x == 0:
			animated_sprite.play("run_down")
		elif direction_y <= 0 and direction_x ==0:
			animated_sprite.play("run_up")
		else:
			animated_sprite.play("run_side")
		
	# Flips the sprite
	if direction_x > 0:
		animated_sprite.flip_h = false
	if direction_x < 0:
		animated_sprite.flip_h = true
		
	# Play basic attacking animations
	if Input.is_action_just_pressed("attack") and not attack:
		attack = true
		
		if direction_x == 0 and direction_y == 0:
			animated_sprite.play("atk_down")
		elif direction_y >= 0 and direction_x == 0:
			animated_sprite.play("atk_down")
		elif direction_y <= 0 and direction_x ==0:
			animated_sprite.play("atk_up")
		else:
			animated_sprite.play("atk_side")
