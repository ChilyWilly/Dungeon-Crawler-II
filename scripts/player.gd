extends CharacterBody2D


class_name PlayerCharacter

var SPEED = 120.0

var last_direction: Vector2 = Vector2.DOWN
var attack = false
var attack_cooldown = false
var debug_on = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timeout: Timer = $AttackTimeout
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var shadow: Sprite2D = $Shadow


func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _on_animation_finished():
	if animated_sprite.animation.begins_with("atk"):
		attack = false
		if debug_on == false:
			SPEED = 120.0
		else:
			SPEED = 200.0
	elif animated_sprite.animation.begins_with("charge"):
		attack_cooldown = true
		attack = false
		if debug_on == false:
			SPEED = 120.0
		else:
			SPEED = 200.0
		attack_timeout.start()


func _physics_process(_delta: float) -> void:
	debug_mode()
	process_animations()
	movement()
	move_and_slide()


func movement() -> void:
	# Get the input direction	
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO


func process_animations() -> void:
	
	if velocity != Vector2.ZERO:
		animations("run", last_direction)
	else:
		animations("idle", last_direction)


func debug_mode():
	
	if Input.is_action_just_pressed("shift"):
		debug_on = not debug_on
		if debug_on == true:
			collision_shape.disabled = true
			animated_sprite.modulate = Color.BLACK
			shadow.modulate = Color.BLACK
			SPEED = 200.0
		else:
			collision_shape.disabled = false
			animated_sprite.modulate = Color.WHITE
			shadow.modulate = Color.BLACK
			SPEED = 120.0


func animations(prefix: String, dir: Vector2) -> void:
	# Play idle and movement animations
	if not attack:
		
		if dir.x != 0:
			animated_sprite.flip_h = dir.x < 0
			animated_sprite.play(prefix +"_side")
		elif dir.y > 0:
			animated_sprite.play(prefix + "_down")
		elif dir.y < 0:
			animated_sprite.play(prefix + "_up")
		
	# Play basic attacking animations
	if Input.is_action_just_pressed("attack") and not attack:
		SPEED = 0
		attack = true
		
		if dir.x != 0:
			animated_sprite.play("atk_side")
		elif dir.y > 0:
			animated_sprite.play("atk_down")
		elif dir.y < 0:
			animated_sprite.play("atk_up")
			
	if Input.is_action_pressed("attack") and not attack and not attack_cooldown:
		SPEED = 0
		attack = true
		
		if dir.x != 0:
			animated_sprite.play("charge_side")
		elif dir.y > 0:
			animated_sprite.play("charge_down")
		elif dir.y < 0:
			animated_sprite.play("charge_up")


func _on_attack_timeout_timeout() -> void:
	attack_cooldown = false
