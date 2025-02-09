extends Node2D


@export var game_level : PackedScene

@onready var fading_ui_layer: FadingUILayer = $FadingUILayer
@onready var girl_npc: GirlNPC = $MapObjects/GirlNPC
@onready var boy_npc: BoyNPC = $MapObjects/BoyNPC
@onready var robot: Robot = $MapObjects/Robot


var dad_first_dialogue : Array[String] = ["Ta-da! This is the special gift I was talking about.", "A cool little robot toy!"]
var boy_first_dialogue : Array[String] = ["Yay!"]
var dad_second_dialogue : Array[String] = ["Wait... uh Ariel, what are you doing?"]
var dad_thrid_dialogue : Array[String] = ["What a mess you made! Ariel, we need to talk after this."]
var boy_second_dialogue : Array[String] = ["Waaaah! You broke it!"]
var dad_fourth_dialogue : Array[String] = ["Hey, it’s okay, Jack! We’re going to fix it. I promise.", 
"We just need to find all the pieces and put it back together.", 
"Wait here, I will find the pieces"] 


func _ready() -> void: 
	await fading_ui_layer.fade_out().finished
	await get_tree().create_timer(1.5).timeout
	
	DialogueBox.start_new_dialogue(dad_first_dialogue)
	await DialogueBox.dialogue_completed
	
	boy_npc.is_celebrating = true
	DialogueBox.start_new_dialogue(boy_first_dialogue, DialogueBox.portrait_boy_happy)
	await DialogueBox.dialogue_completed
	
	girl_npc.is_walk = true
	await girl_npc.walk_finished
	
	girl_npc.is_mean = true
	DialogueBox.start_new_dialogue(dad_second_dialogue)
	await DialogueBox.dialogue_completed
	
	girl_npc.is_break = true
	await  girl_npc.break_completed
	
	var crash_tween = fading_ui_layer.fade_crash_out()
	boy_npc.is_crying = true
	robot.set_broke()
	await crash_tween.finished
	
	DialogueBox.start_new_dialogue(dad_thrid_dialogue)
	await DialogueBox.dialogue_completed
	
	DialogueBox.start_new_dialogue(boy_second_dialogue, DialogueBox.portrait_boy)
	await DialogueBox.dialogue_completed
	
	DialogueBox.start_new_dialogue(dad_fourth_dialogue)
	await DialogueBox.dialogue_completed
	
	await get_tree().create_timer(1).timeout
	await fading_ui_layer.fade_in().finished
	get_tree().change_scene_to_packed(game_level)
