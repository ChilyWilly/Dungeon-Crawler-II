extends CharacterBody2D


var SPEED = 120.0

var last_direction: Vector2 = Vector2.DOWN
var attack = false
var attack_cooldown = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timeout: Timer = $AttackTimeout


func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)


func _on_animation_finished():
	if animated_sprite.animation.begins_with("atk"):
		attack = false
		SPEED = 120.0
	elif animated_sprite.animation.begins_with("charge"):
		attack_cooldown = true
		attack = false
		SPEED = 120.0
		attack_timeout.start()


func _physics_process(delta: float) -> void:
	
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
	
	process_animations(last_direction)


func process_animations(direction) -> void:
	
	if velocity != Vector2.ZERO:
		animations("run", direction)
	else:
		animations("idle", direction)


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
		SPEED = 20
		attack = true
		
		if dir.x != 0:
			animated_sprite.play("atk_side")
		elif dir.y > 0:
			animated_sprite.play("atk_down")
		elif dir.y < 0:
			animated_sprite.play("atk_up")
			
	if Input.is_action_pressed("attack") and not attack and not attack_cooldown:
		SPEED = 20
		attack = true
		
		if dir.x != 0:
			animated_sprite.play("charge_side")
		elif dir.y > 0:
			animated_sprite.play("charge_down")
		elif dir.y < 0:
			animated_sprite.play("charge_up")


func _on_attack_timeout_timeout() -> void:
	attack_cooldown = false
