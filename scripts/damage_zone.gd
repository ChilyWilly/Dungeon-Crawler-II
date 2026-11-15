extends Area2D


@onready var player_i_frames: Timer = $PlayerIFrames


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerCharacter:
		GameManager.player_health -= 10
		GameManager.player_iframes = true
		player_i_frames.start()
		if GameManager.player_health <= 0:
			GameManager.player_health = 100
			get_tree().call_deferred("reload_current_scene")


func _on_player_i_frames_timeout() -> void:
	GameManager.player_iframes = false
