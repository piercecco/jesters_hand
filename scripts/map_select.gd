extends Node2D


var mouse_vec := Vector2(0.0, 0.0)
@onready var map_markers = []

func _ready() -> void:
	CardManager.shuffle_deck()
	PlayerManager.energy_left = 5
	for i in $MapManagerMarkers.get_children():
		map_markers.append(i)
	reset_player_position()

func reset_player_position():
	$PlayerMarker.position = map_markers[MapManager.temp_current_map_position].position
	MapManager.has_to_reset_player_pos = false

func _process(delta: float) -> void:
	if $PlayerMarker.global_position.x > 672:
		$MapBackground.global_position.x = $PlayerMarker.global_position.x
		$Camera2D.global_position.x = $PlayerMarker.global_position.x
	
	if MapManager.has_to_reset_player_pos:
		reset_player_position()
	
	if $PlayerMarker.position.distance_to(map_markers[MapManager.temp_current_map_position].position) > 10:
		$PlayerMarker.position += $PlayerMarker.position.direction_to(map_markers[MapManager.temp_current_map_position].position)*delta*180
	else:
		MapManager.current_map_location = MapManager.temp_current_map_position
		if MapManager.temp_current_map_position not in MapManager.used_markers:
			MapManager.activate_marker()

func check_if_can_go_to_marker(which_marker):
	if which_marker in MapManager.possible_connections[MapManager.current_map_location]:
		return true

func _on_1_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(1):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 1

func _on_2_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(2):
		PlayerManager.can_loop_map = false
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 2

func _on_3_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(3):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 3

func _on_4_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(4):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 4

func _on_5_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(5):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 5

func _on_6_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(6):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 6

func _on_7_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(7):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 7

func _on_8_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(8):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 8

func _on_9_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(9):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 9

func _on_10_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(10):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 10


func _on_11_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(11):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 11


func _on_12_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(12):
		PlayerManager.can_loop_map = true
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 12


func _on_13_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(13):
		MapManager.has_selected_marker = true
		MapManager.temp_current_map_position = 13


func _on_14_pressed() -> void:
	if !MapManager.has_selected_marker and check_if_can_go_to_marker(14):
		MapManager.has_selected_marker = true
		PlayerManager.is_in_boss_area = true
		MapManager.temp_current_map_position = 14


func _on_button_pressed() -> void:
	MapManager.has_selected_marker = true
	PlayerManager.is_in_boss_area = true
	MapManager.temp_current_map_position = 14
	$PlayerMarker.position = map_markers[MapManager.temp_current_map_position].position
