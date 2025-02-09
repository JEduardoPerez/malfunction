extends Node2D


@onready var fading_ui_layer: FadingUILayer = $FadingUILayer
@onready var thankyou_label: Label = $CreditsUI/ThankyouLabel
@onready var the_end: Label = $CreditsUI/TheEnd
@onready var made_by_label: Label = $CreditsUI/MadeByLabel
@onready var task_label: Label = $CreditsUI/TaskLabel
@onready var name_label: Label = $CreditsUI/NameLabel
@onready var credits_music: AudioStreamPlayer = $CreditsMusic


func _ready() -> void:
	credits_music.finished.connect(_on_credits_finished)
	fading_ui_layer.fade_out()
	made_by_label.modulate.a = 0
	task_label.modulate.a = 0
	name_label.modulate.a = 0
	the_end.modulate.a = 0
	fade_music_in()
	await get_tree().create_timer(2).timeout
	tween_names()


func tween_names() -> void: 
	var tween := create_tween()
	tween.tween_property(made_by_label, "modulate:a", 1, 1)
	
	task_label.text = "Game Design"
	name_label.text = "AngelNHorns"
	await fade_names().finished
	
	task_label.text = "Artist"
	name_label.text = "AngelNHorns"
	await fade_names().finished
	
	task_label.text = "Programming"
	name_label.text = "Spirits"
	await fade_names().finished
	
	tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(thankyou_label, "modulate:a", 0, 1)
	tween.tween_property(made_by_label, "modulate:a", 0, 1)
	tween.tween_property(the_end, "modulate:a", 1, 3).set_delay(2)


func fade_names() -> Tween: 
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(task_label, "modulate:a", 1, 1)
	tween.tween_property(name_label, "modulate:a", 1, 1)
	tween.tween_property(task_label, "modulate:a", 0, 1).set_delay(6)
	tween.tween_property(name_label, "modulate:a", 0, 1).set_delay(6)
	return tween


func fade_music_in() -> void: 
	credits_music.volume_db = -30
	credits_music.play()
	var tween := create_tween()
	tween.tween_property(credits_music, "volume_db", 0, 1)


func _on_credits_finished() -> void: 
	await fading_ui_layer.fade_in_slow().finished
	get_tree().quit()
