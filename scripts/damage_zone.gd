extends Area2D


signal player_death
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.player_health -= 50
		if GameManager.player_health > 0:
			print(GameManager.player_health)
		else:
			GameManager.player_health = 100
			get_tree().call_deferred("reload_current_scene")
