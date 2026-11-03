extends Area2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.player_health -= 50
		print(GameManager.player_health)
