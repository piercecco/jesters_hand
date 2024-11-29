extends Node

var temp_current_map_position := 0
var current_map_location := 0
var has_selected_marker := false

var used_markers = []

var has_to_reset_player_pos := false

const possible_connections := [
	 [1, 6], #0
	 [2, 4], #1
	 [3], #2
	 [9], #3
	 [5], #4
	 [3, 9], #5
	 [2, 7], #6
	 [8], #7
	 [9, 11], #8
	 [10], #9
	 [12, 13], #10
	 [12, 10], #11
	 [13, 14], #12
	 [14], #13
	 [0], #14
	]

var current_combat_difficulty := 0

func activate_marker():
	has_selected_marker = false
	used_markers.append(current_map_location)
	if current_map_location == 1 or current_map_location == 5 or current_map_location == 6 or current_map_location == 7 or current_map_location == 10 or current_map_location == 11:
		start_combat_area()
	elif current_map_location == 2 or current_map_location == 12:
		start_resting_area()
	elif current_map_location == 4 or current_map_location == 3 or current_map_location == 8 or current_map_location == 9 or current_map_location == 13:
		start_hard_combat_area()
	elif current_map_location == 14:
		start_boss_area()

func start_combat_area():
	current_combat_difficulty = 0
	get_tree().change_scene_to_file("res://scenes/fighting_map_area.tscn")

func start_hard_combat_area():
	current_combat_difficulty = 1
	get_tree().change_scene_to_file("res://scenes/fighting_map_area.tscn")

func start_resting_area():
	get_tree().change_scene_to_file("res://scenes/resting_map_area.tscn")

func start_boss_area():
	current_combat_difficulty = 2
	get_tree().change_scene_to_file("res://scenes/fighting_map_area.tscn")
