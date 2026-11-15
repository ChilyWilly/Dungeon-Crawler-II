extends Area2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var open_collision: CollisionShape2D = $OpenCollision
@onready var hud_text: Label = $HUD/HUDText


signal chest_opened


func _process(_delta: float) -> void:
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body is PlayerCharacter:
			hud_text.text = "PRESS SPACE TO OPEN"
			if Input.is_action_just_pressed("accept"):
				animated_sprite.play("open")
				open_collision.set_deferred("disabled", true)
				chest_opened.emit()
		else:
			hud_text.text = ""
