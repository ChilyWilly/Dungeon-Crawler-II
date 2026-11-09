extends Label


@onready var money_label: Label = $"."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_label.text = "Money: " + str(GameManager.money)
