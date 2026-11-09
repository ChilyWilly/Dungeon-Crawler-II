extends AnimatedSprite2D


@onready var heart: AnimatedSprite2D = $"."


# Called when the node enters the scene tree for the first time.
func hearts():
	if GameManager.player_health >= 76:
		heart.play("full")
	elif GameManager.player_health >= 51:
		heart.play("over_half")
	elif GameManager.player_health >= 26:
		heart.play("half")
	elif GameManager.player_health >= 1:
		heart.play("under_half")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hearts()
