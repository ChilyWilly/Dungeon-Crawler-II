extends Area2D

signal button_pressed

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var event_timer: Timer = $EventTimer


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		animated_sprite.play("pressed")
		collision_shape.queue_free()
		event_timer.start()


func _on_event_timer_timeout() -> void:
	button_pressed.emit()
