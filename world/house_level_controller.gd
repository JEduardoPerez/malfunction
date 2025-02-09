extends Node2D


@export var backyard_level : PackedScene

@onready var boy_npc: BoyNPC = $Characters/BoyNPC
@onready var girl_npc: GirlNPC = $Characters/GirlNPC
@onready var dad_sprite: AnimatedSprite2D = $Characters/DadSprite
@onready var fading_ui_layer: FadingUILayer = $FadingUILayer


var inside_dialogue_text : Array[String] = [
	"Hey kids, I’ve got a surprise for you!", 
	"Come on, let’s head to the backyard.",
	"Trust me, you’re going to love it!"
]

func _ready() -> void:
	await fading_ui_layer.fade_out().finished
	DialogueBox.start_new_dialogue(inside_dialogue_text)
	await DialogueBox.dialogue_completed
	boy_npc.is_celebrating = true
	girl_npc.is_celebrating = true
	await get_tree().create_timer(3).timeout
	await fading_ui_layer.fade_in().finished
	get_tree().change_scene_to_packed(backyard_level)
	
