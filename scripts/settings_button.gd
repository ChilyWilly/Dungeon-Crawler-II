extends Button


@onready var settings_button: Button = $"."
@onready var start_game: Button = $"../StartGame"
@onready var exit_game: Button = $"../ExitGame"

@onready var back: Button = $"../Back"
@onready var music: Button = $"../Music"


func _on_pressed() -> void:
	
	settings_button.disabled = true
	settings_button.visible = false
	start_game.disabled = true
	start_game.visible = false
	exit_game.disabled = true
	exit_game.visible = false

	back.disabled = false
	back.visible = true
