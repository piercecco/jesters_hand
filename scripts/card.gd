extends Node2D

var which_card := ""

var effect_icon_load = preload("res://scenes/effect_icon.tscn")

var card_title = ""

var possible_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

@onready var actual_card_title = $CardBackground/MarginContainer/VBoxContainer/CardTitle/ActualTitle
@onready var show_card_title = $CardBackground/MarginContainer/VBoxContainer/CardTitle
@onready var show_card_descr = $CardBackground/MarginContainer/VBoxContainer/MarginContainer/Description

func _ready() -> void:
	$activeLabel.hide()
	$HoverHint.hide()
	var selected = randi_range(0, len(CardManager.avaliable_cards)-1)
	which_card = CardManager.avaliable_cards[selected]
	CardManager.avaliable_cards.erase(CardManager.avaliable_cards[selected])
	CardManager.docked_cards -= 1
	
	for t in CardManager.spell_register:
		if CardManager.spell_register[t][1] == which_card:
			card_title = t
	show_card_title.text = card_title
	if CardManager.spell_register[card_title][0]:
		
		actual_card_title.text = CardManager.actual_cards_display[which_card]["display_name"]
		show_card_descr.text = CardManager.actual_cards_display[which_card]["description"]
	else:
		var tmp_string = ""
		for i in CardManager.actual_cards_display[which_card]["display_name"]:
			if i != " ":
				tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
			else:
				tmp_string += " "
		tmp_string += ""
		actual_card_title.text = tmp_string
		tmp_string = "[i]"
		for i in CardManager.actual_cards_display[which_card]["description"]:
			if i != " ":
				tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
			else:
				tmp_string += " "
		tmp_string += "[/i]"
		show_card_descr.text = tmp_string
	update_card_cost()
	
	for i in range(9):
		var tmp_effect_icon = effect_icon_load.instantiate()
		tmp_effect_icon.id = i
		tmp_effect_icon.scale = Vector2(0.15, 0.15)
		tmp_effect_icon.position.y = -10+(i)*(64*0.275)
		if CardManager.spell_register[card_title][0]:
			tmp_effect_icon.is_enabled = CardManager.actual_cards_display[which_card][CardManager.effects_list[i]]
		get_node("EffectsList").add_child(tmp_effect_icon)
		

func redraw_card():
	for t in CardManager.spell_register:
		if CardManager.spell_register[t][1] == which_card:
			card_title = t
	show_card_title.text = card_title
	if CardManager.spell_register[card_title][0]:
		
		actual_card_title.text = CardManager.actual_cards_display[which_card]["display_name"]
		show_card_descr.text = CardManager.actual_cards_display[which_card]["description"]
	else:
		pass
		"""
		var tmp_string = ""
		for i in CardManager.actual_cards_display[which_card]["display_name"]:
			if i != " ":
				tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
			else:
				tmp_string += " "
		tmp_string += ""
		actual_card_title.text = tmp_string
		tmp_string = "[i]"
		for i in CardManager.actual_cards_display[which_card]["description"]:
			if i != " ":
				tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
			else:
				tmp_string += " "
		tmp_string += "[/i]"
		show_card_descr.text = tmp_string
		"""
	update_card_cost()
	

func refresh_effect_list():
	for t in range(len($EffectsList.get_children())):
		if CardManager.spell_register[card_title][0]:
			$EffectsList.get_children()[t].is_enabled = CardManager.actual_cards_display[which_card][CardManager.effects_list[t]]
		else:
			$EffectsList.get_children()[t].is_enabled = false
		$EffectsList.get_children()[t].refresh()


func reload_card():
	if CardManager.docked_cards > 0:
		var selected = randi_range(0, len(CardManager.avaliable_cards)-1)
		which_card = CardManager.avaliable_cards[selected]
		CardManager.avaliable_cards.erase(CardManager.avaliable_cards[selected])
		CardManager.docked_cards -= 1
		
		for t in CardManager.spell_register:
			if CardManager.spell_register[t][1] == which_card:
				card_title = t
		show_card_title.text = card_title
		if CardManager.spell_register[card_title][0]:
			
			actual_card_title.text = CardManager.actual_cards_display[which_card]["display_name"]
			show_card_descr.text = CardManager.actual_cards_display[which_card]["description"]
		else:
			var tmp_string = ""
			for i in CardManager.actual_cards_display[which_card]["display_name"]:
				if i != " ":
					tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
				else:
					tmp_string += " "
			tmp_string += ""
			actual_card_title.text = tmp_string
			tmp_string = "[i]"
			for i in CardManager.actual_cards_display[which_card]["description"]:
				if i != " ":
					tmp_string += possible_chars[randi_range(0, len(possible_chars)-1)]
				else:
					tmp_string += " "
			tmp_string += "[/i]"
			show_card_descr.text = tmp_string
		update_card_cost()
		
		for i in range(len($EffectsList.get_children())):
			if CardManager.spell_register[card_title][0]:
				$EffectsList.get_children()[i].is_enabled = CardManager.actual_cards_display[which_card][CardManager.effects_list[i]]
	else:
		show_card_title.text = ""
		actual_card_title.text = ""
		show_card_descr.text = ""
		if CardManager.docked_cards <= 0:
			CardManager.shuffle_deck()
	
	
	refresh_effect_list()

func update_card_cost():
	if CardManager.spell_register[card_title][0]:
		$CardBackground/CardCost/CardCostLabel.text = str(CardManager.actual_cards_display[which_card]["cost"])
	else:
		$CardBackground/CardCost/CardCostLabel.text = "?"
	

func _process(delta: float) -> void:
	if !CardManager.spell_register[card_title][0]:
		for i in range(len(actual_card_title.text)):
			if randi_range(1, 100) <= 4:
				if actual_card_title.text[i] != " " and i > 2 and i < len(actual_card_title.text)-4:
					actual_card_title.text[i] = possible_chars[randi_range(0, len(possible_chars)-1)]
		for i in range(len(show_card_descr.text)):
			if randi_range(1, 100) <= 2:
				if show_card_descr.text[i] != " " and i > 2 and i < len(show_card_descr.text)-4:
					show_card_descr.text[i] = possible_chars[randi_range(0, len(possible_chars)-1)]
		
		"""
		if str(PlayerManager.current_card) != "":
			if PlayerManager.current_card == self:
				$activeLabel.show()
			else:
				$activeLabel.hide()
		"""

func hide_active_labels():
	$activeLabel.hide()


func _on_activate_button_pressed() -> void:
	PlayerManager.hide_all_active_card_statuses()
	$activeLabel.show()
	
	PlayerManager.current_card = self
	PlayerManager.is_using_card = true
	PlayerManager.using_card = which_card

func _on_activate_button_mouse_entered() -> void:
	$HoverHint.show()

func _on_activate_button_mouse_exited() -> void:
	$HoverHint.hide()
