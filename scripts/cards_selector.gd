extends Control

var is_deck_menu_showing := false

func _ready() -> void:
	$DeckMenu.hide()

func _process(delta: float) -> void:
	if PlayerManager.is_performing:
		$PerformActiveLabel.show()
	else:
		$PerformActiveLabel.hide()
	
	#$CurrentDeckTitle.text = "Current deck contains: \n"
	$CurrentDeckTitle/CurrentDeckContents.text = ""
	for k in CardManager.spell_register:
		for i in range(len(CardManager.player_deck)):
			if CardManager.spell_register[k][1] == CardManager.player_deck[i]:
				if CardManager.spell_register[k][0]:
					$CurrentDeckTitle/CurrentDeckContents.text += str(CardManager.actual_cards_display[CardManager.player_deck[i]]["display_name"]) + "\n"
				else:
					$CurrentDeckTitle/CurrentDeckContents.text += "[color=f08080]Card not yet discovered[/color]\n"
	$CurrentDeckTitle/CurrentDeckContents.text += "\n\n"
	
	$DeckCards/Label.text = str(CardManager.docked_cards)
	$Energy.text = "Energy left: " + str(PlayerManager.energy_left)
	if CardManager.has_to_reload_all_cards:
		for i in $Cards.get_children():
			i.redraw_card()

func hide_active_labels():
	for i in $Cards.get_children():
		i.hide_active_labels()


func _on_show_deck_button_pressed() -> void:
	if is_deck_menu_showing:
		is_deck_menu_showing = false
		$DeckMenu.hide()
	else:
		is_deck_menu_showing = true
		$DeckMenu.refresh_deck_menu()
		$DeckMenu.show()
