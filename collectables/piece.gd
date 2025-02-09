extends Area2D
class_name Piece

@export_range(0,3) var part_piece : int = 0
@export var collect_piece : CollectedPiece
@export var explinatory_animation : String = ""
@export var fountain : Fountain

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cursor_explinatory: Explanatory = $CursorExplinatory

var is_available_to_collect : bool : set = set_is_available_to_collect
var is_on_repair_mode : bool : set = set_is_on_repair_mode
var player : Player
var is_mouse_on_piece : bool

signal piece_collected

func _ready() -> void:
	cursor_explinatory.shake_completed.connect(_on_cursor_shake_complete)
	body_entered.connect(_on_piece_body_entered)
	body_exited.connect(_on_piece_body_exited)
	mouse_entered.connect(_on_piece_mouse_entered)
	mouse_exited.connect(_on_piece_mouse_exited)
	sprite_2d.frame = part_piece
	await collect_piece.ready
	collect_piece.part_piece = part_piece


func _input(event: InputEvent) -> void:
	if not is_available_to_collect or is_on_repair_mode: return
	if event.is_action_pressed("click") and player != null and is_mouse_on_piece: 
		collect()


func collect() -> void: 
	set_process_input(false)
	hide()
	cursor_explinatory.stop_animation()
	collect_piece.collect_piece()
	piece_collected.emit()
	if fountain != null: fountain.frame = 0
	await collect_piece.collected_completed
	queue_free()


func set_is_available_to_collect(new_value : bool) -> void: 
	is_available_to_collect = new_value
	sprite_2d.visible = is_available_to_collect


func set_is_on_repair_mode(new_value : bool) -> void: 
	is_on_repair_mode = new_value
	cursor_explinatory.is_repair_mode = is_on_repair_mode


func _on_piece_body_entered(body : Node2D) -> void: 
	if body is Player: 
		player = body
		if not explinatory_animation.is_empty():
			if explinatory_animation == "side": cursor_explinatory.play_sides()
			else: cursor_explinatory.play_vertical()


func _on_piece_body_exited(body : Node2D) -> void: 
	if body is Player: player = null
	cursor_explinatory.stop_animation()


func _on_piece_mouse_entered() -> void: 
	is_mouse_on_piece = true


func _on_piece_mouse_exited() -> void: 
	is_mouse_on_piece = false


func _on_cursor_shake_complete() -> void: 
	collect()
