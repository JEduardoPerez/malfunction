extends Node2D


@onready var fading_ui_layer: FadingUILayer = $FadingUILayer
@onready var boy_npc: BoyNPC = $MapObjects/BoyNPC
@onready var girl_npc: GirlNPC = $MapObjects/GirlNPC
@onready var dog: Dog = $MapObjects/Dog
@onready var robot: Robot = $MapObjects/Robot


func _ready() -> void:
	fading_ui_layer.fade_out()
	boy_npc.is_crying = true
	robot.set_broke()
