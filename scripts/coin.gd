extends Area2D


@onready var coin: Area2D = $"."


func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.money += 1
		print(GameManager.money)
		coin.queue_free()
