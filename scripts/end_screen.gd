extends Control


func _on_reset_button_pressed() -> void:
	PlayerManager._reset_player()
	TurnManager.is_turn_going = false
	MapManager.used_markers = []
	MapManager.temp_current_map_position *= 0
	MapManager.current_map_location *= 0
	MapManager.has_selected_marker = false
	CardManager.player_deck = []
	CardManager.avaliable_cards = []
	CardManager.card_pack_price = 10.0
	EntityManager.level_entities = []
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().free()
