extends Area2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var open_collision: CollisionShape2D = $OpenCollision

signal chest_opened

func _process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body is CharacterBody2D:
			if Input.is_action_just_pressed("accept"):
				animated_sprite.play("open")
				open_collision.set_deferred("disabled", true)
				chest_opened.emit()
