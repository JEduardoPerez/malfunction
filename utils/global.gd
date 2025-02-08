extends Node

const TILE_SIZE : int = 24


func change_scene(scene : PackedScene) -> void: 
	get_tree().change_scene_to_packed(scene)


func add_short_animated_vfx(animated_scene : PackedScene, world_position : Vector2, direction : int = 1) -> void: 
	var animated_instance := animated_scene.instantiate() as AnimatedSprite2D
	animated_instance.global_position = world_position
	animated_instance.animation_finished.connect(animated_instance.queue_free)
	animated_instance.scale.x = sign(direction)
	get_tree().root.get_child(get_tree().root.get_child_count()-1).add_child(animated_instance)
