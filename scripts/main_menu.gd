extends Control

@onready var play_button := $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/PlayButton
@onready var options_button := $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/OptionsButton
@onready var quit_button := $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/QuitButton

const alphabeth := "?#@[]={}0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

var play_button_text := "____"
var options_button_text := "_______"
var quit_button_text := "____"

var play_hover := false
var options_hover := false
var quit_hover := false

func _ready() -> void:
	CardManager.create_player_deck()
	play_button.text = rando_string(4)
	options_button.text = rando_string(7)
	quit_button.text = rando_string(4)

func _process(delta: float) -> void:
	$MarginContainer.position.x += delta*5
	$Camera2D.position.x += delta*5
	
	
	if play_hover:
		play_button.text = "PLAY"
	else:
		if randi_range(1, 100) <= 50:
			play_button_text = ""
			play_button.text = rando_string(4)
		
	if options_hover:
		options_button.text = "OPTIONS"
	else:
		if randi_range(1, 100) <= 50:
			options_button_text = ""
			options_button.text = rando_string(7)
		
	if quit_hover:
		quit_button.text = "QUIT"
	else:
		if randi_range(1, 100) <= 50:
			quit_button_text = ""
			quit_button.text = rando_string(4)

func rando_string(length):
	var txt = ""
	for i in range(length):
		txt += alphabeth[randi_range(0, len(alphabeth)-1)]
	return txt

func _on_play_button_pressed() -> void:
	CardManager.generate_register()
	get_tree().change_scene_to_file("res://scenes/map_select.tscn")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().free()


func _on_play_button_mouse_entered() -> void:
	play_hover = true


func _on_play_button_mouse_exited() -> void:
	play_hover = false


func _on_options_button_mouse_entered() -> void:
	options_hover = true


func _on_options_button_mouse_exited() -> void:
	options_hover = false


func _on_quit_button_mouse_entered() -> void:
	quit_hover = true


func _on_quit_button_mouse_exited() -> void:
	quit_hover = false
