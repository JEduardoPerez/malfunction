extends Node2D


@export var house_level : PackedScene

@onready var start_game_area: Area2D = $StartGameArea
@onready var fading_ui_layer: FadingUILayer = $FadingUILayer
@onready var start_sfx: ExtendedAudioStreamPlayer = $StartSFX
@onready var title_music: AudioStreamPlayer = $TitleMusic

var is_mouse_over_start_game : bool


func _ready() -> void:
	fading_ui_layer.fade_out()
	start_game_area.mouse_entered.connect(_on_start_game_area_mouse_entered)
	start_game_area.mouse_exited.connect(_on_start_game_area_mouse_exited)
	fade_music_in()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and is_mouse_over_start_game:
		set_process_input(false)
		tween_start()
		start_sfx.play()
		fade_music_out()
		await get_tree().create_timer(3).timeout 
		await fading_ui_layer.fade_in().finished
		get_tree().change_scene_to_packed(house_level)


func fade_music_in() -> void: 
	title_music.volume_db = -30
	title_music.play()
	var tween := create_tween()
	tween.tween_property(title_music, "volume_db", 0, 1)


func fade_music_out() -> void: 
	var tween := create_tween()
	tween.tween_property(title_music, "volume_db", -24, 1)


func tween_start() -> void: 
	var tween := create_tween()
	for i in range(10):
		tween.tween_property(start_game_area, "modulate:a", 0, 0)
		tween.tween_interval(.1)
		tween.tween_property(start_game_area, "modulate:a", 1, 0)
		tween.tween_interval(.1)


func _on_start_game_area_mouse_entered() -> void: 
	is_mouse_over_start_game = true
	print("Mouse entered")


func _on_start_game_area_mouse_exited() -> void:
	is_mouse_over_start_game = false
