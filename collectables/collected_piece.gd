extends Node2D
class_name CollectedPiece


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collected: ExtendedAudioStreamPlayer = $Collected
@onready var sprite_2d: Sprite2D = $Sprite2D

var part_piece : int = 0 : set = set_part_piece

signal collected_completed


func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finish)


func collect_piece() -> void: 
	animation_player.play("collected")
	collected.play_at_random_pitch()


func set_part_piece(new_part : int) -> void: 
	part_piece = new_part
	sprite_2d.frame = part_piece


func _on_animation_finish(_animation_name : String) -> void: 
	collected_completed.emit()
	queue_free()
