extends CharacterBody2D


var SPEED = 120.0


func _physics_process(delta: float) -> void:
	movement()
	
	
func movement():
	pass


	move_and_slide()
