extends Sprite2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed : int = 64


func _process(delta: float) -> void:
	if animation_player.is_playing(): 
		position += Vector2.DOWN * speed * delta
