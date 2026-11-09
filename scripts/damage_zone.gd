extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter:
		GameManager.player_health -= 10
		if GameManager.player_health > 0:
			print(GameManager.player_health)
		else:
			GameManager.player_health = 100
			get_tree().call_deferred("reload_current_scene")
