extends Label


@onready var health: Label = $"."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	health.text = str(GameManager.player_health)
