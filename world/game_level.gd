extends Node2D


@export var credits_scene : PackedScene = load("res://screens/credit_screen.tscn")
@export var player : Player

@onready var fading_ui_layer: FadingUILayer = $FadingUILayer
@onready var boy_npc: BoyNPC = $MapObjects/BoyNPC
@onready var girl_npc: GirlNPC = $MapObjects/GirlNPC
@onready var dog: Dog = $MapObjects/Dog
@onready var robot: Robot = $MapObjects/Robot
@onready var fountain: Fountain = $MapObjects/Fountain
@onready var bush_piece: Piece = $MapObjects/Piece
@onready var corner_piece: Piece = $MapObjects/Piece2
@onready var dog_piece: Piece = $MapObjects/Piece3
@onready var fountain_piece: Piece = $MapObjects/Piece4
@onready var repair_animation_player: AnimationPlayer = $FixUI/AnimationPlayer
@onready var ball: Ball = $MapObjects/Ball
@onready var game_music: AudioStreamPlayer = $GameMusic


var player_has_piece : bool : set =set_player_has_piece


func _ready() -> void:
	ball.ball_thrown.connect(_on_ball_thrown)
	dog.dog_drop_piece.connect(_on_dog_drop_piece)
	player.game_completed.connect(_on_game_completed)
	fading_ui_layer.fade_out()
	fade_music_in()
	robot.set_broke()
	fountain.set_piece()
	bush_piece.is_available_to_collect = false
	corner_piece.is_available_to_collect = true
	dog_piece.is_available_to_collect = false
	fountain_piece.is_available_to_collect = false
	player.piece_fix_completed.connect(set_player_has_piece.bind(false))
	set_piece_collected_connection()


func set_piece_collected_connection() -> void: 
	bush_piece.piece_collected.connect(set_player_has_piece.bind(true))
	corner_piece.piece_collected.connect(set_player_has_piece.bind(true))
	dog_piece.piece_collected.connect(set_player_has_piece.bind(true))
	fountain_piece.piece_collected.connect(set_player_has_piece.bind(true))


func set_piece_repair_mode(is_repair : bool) -> void: 
	if bush_piece != null: bush_piece.is_on_repair_mode = is_repair
	if corner_piece != null: corner_piece.is_on_repair_mode = is_repair
	if dog_piece != null: dog_piece.is_on_repair_mode = is_repair
	if fountain_piece != null: fountain_piece.is_on_repair_mode = is_repair
	robot.is_on_repair_mode = is_repair


func set_player_has_piece(new_value : bool) -> void: 
	player_has_piece = new_value
	var repair_animation : String = "fix" if player_has_piece else "no_fix"
	set_piece_repair_mode(player_has_piece)
	repair_animation_player.play(repair_animation)


func fade_music_in() -> void: 
	game_music.volume_db = -30
	game_music.play()
	var tween := create_tween()
	tween.tween_property(game_music, "volume_db", 0, 1)


func fade_music_out() -> void: 
	var tween := create_tween()
	tween.tween_property(game_music, "volume_db", -24, 3)


func _on_ball_thrown() -> void: 
	dog.set_final_target_location()


func _on_dog_drop_piece() -> void: 
	dog_piece.is_available_to_collect = true


func _on_game_completed() -> void:
	robot.set_fix()
	fade_music_out()
	await get_tree().create_timer(2).timeout
	await fading_ui_layer.fade_in().finished
	get_tree().change_scene_to_packed(credits_scene)
