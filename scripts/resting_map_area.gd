extends Node2D

var refresh_shop_price := 100.0

var is_deck_menu_showing := false

func _ready() -> void:
	PlayerManager.resting_points_visited += 1
	PlayerManager.is_in_resting_area = true
	if PlayerManager.can_loop_map:
		$LoopButton.text = "Loop back: (" + str((250*(((PlayerManager.resting_points_visited/2)*(PlayerManager.resting_points_visited/2))+1))) + "g)"
		$LoopButton.show()
	else:
		$LoopButton.hide()

func _process(delta: float) -> void:
	
	$RefreshShopButton.text = "Refresh shop: (" + str(refresh_shop_price) + "g)"
	if PlayerManager.health < PlayerManager.max_health*0.9:
		PlayerManager.health += (PlayerManager.max_health/200)*delta
	else:
		PlayerManager.health = PlayerManager.max_health*0.9
	$CurrentGoldLabel.text = "Current Gold: " + str(snapped(PlayerManager.gold, 0.1)) + "g"
	
	$HealthBars/VBoxContainer/MarginContainer/HealthBar.max_value = PlayerManager.max_health
	$HealthBars/VBoxContainer/MarginContainer/HealthBar.value = PlayerManager.health
	$HealthBars/VBoxContainer/MarginContainer/HealthBar/HealthLabel.text = str(round(PlayerManager.health)) + "/" + str(round(PlayerManager.max_health))
	#$HealthBars/VBoxContainer/MarginContainer2/ShieldBar.value = PlayerManager.shield

func _on_refresh_shop_button_pressed() -> void:
	if PlayerManager.gold >= refresh_shop_price:
		PlayerManager.gold -= refresh_shop_price
		refresh_shop_price *= 2


func _on_heal_button_pressed() -> void:
	if PlayerManager.health < PlayerManager.max_health*0.9:
		PlayerManager.health += PlayerManager.max_health/randi_range(15, 20)


func _on_progress_button_pressed() -> void:
	CardManager.shuffle_deck()
	PlayerManager.can_loop_map = false
	PlayerManager.is_in_resting_area = false
	get_tree().change_scene_to_file("res://scenes/map_select.tscn")


func _on_loop_button_pressed() -> void:
	if PlayerManager.gold >= (250*(((PlayerManager.resting_points_visited/2)*(PlayerManager.resting_points_visited/2))+1)):
		PlayerManager.can_loop_map = false
		PlayerManager.gold -= (250*(((PlayerManager.resting_points_visited/2)*(PlayerManager.resting_points_visited/2))+1))
		CardManager.shuffle_deck()
		MapManager.used_markers = []
		MapManager.temp_current_map_position = 2
		MapManager.current_map_location = 2
		MapManager.has_to_reset_player_pos = true
		MapManager.used_markers.append(2)
		get_tree().change_scene_to_file("res://scenes/map_select.tscn")


func _on_show_deck_button_pressed() -> void:
	if is_deck_menu_showing:
		is_deck_menu_showing = false
		$DeckMenu.hide()
	else:
		is_deck_menu_showing = true
		$DeckMenu.refresh_deck_menu()
		$DeckMenu.show()
