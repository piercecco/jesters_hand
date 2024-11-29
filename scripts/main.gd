extends Node2D


func _ready() -> void:
	RandomNumberGenerator.new()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
