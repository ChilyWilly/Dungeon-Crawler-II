extends "res://scripts/damage_zone.gd"


@onready var spike_collision: CollisionShape2D = $SpikeCollision
@onready var spike_sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if spike_sprite.frame == 3:
		spike_collision.disabled = false
	elif spike_sprite.frame == 8:
		spike_collision.disabled = true
