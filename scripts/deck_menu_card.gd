extends Control

var effect_icon_load = preload("res://scenes/effect_icon.tscn")

var id := 0
var has_been_erased := false
var erase_cost := 25.0

@onready var show_card_title = $CardBackground/MarginContainer/VBoxContainer/CardTitle
@onready var actual_card_title = $CardBackground/MarginContainer/VBoxContainer/CardTitle/ActualTitle
@onready var show_card_descr = $CardBackground/MarginContainer/VBoxContainer/MarginContainer/Description

var possible_chars := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

var card_title := ""
var which_card := ""

func _ready() -> void:
	if PlayerManager.is_in_resting_area:
		$".".custom_minimum_size.y = 250
		$Price.show()
	else:
		$".".custom_minimum_size.y = 175
		$Price.hide()
	$RichTextLabel.hide()
	card_title = ""
	which_card = CardManager.player_deck[id]
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
	$CardBackground/CardCost/CardCostLabel.text = str(CardManager.actual_cards_display[which_card]["cost"])
	for i in range(9):
		var tmp_effect_icon = effect_icon_load.instantiate()
		tmp_effect_icon.id = i
		tmp_effect_icon.scale = Vector2(0.15, 0.15)
		if PlayerManager.is_in_resting_area:
			tmp_effect_icon.position.y = 0+(i)*(64*0.275)
		else:
			tmp_effect_icon.position.y = -50+(i)*(64*0.275)
		if CardManager.spell_register[card_title][0]:
			tmp_effect_icon.is_enabled = CardManager.actual_cards_display[which_card][CardManager.effects_list[i]]
		get_node("EffectsList").add_child(tmp_effect_icon)
	
	if CardManager.spell_register[card_title][0]:
		$CardBackground/MarginContainer/VBoxContainer/CardTitle/UnknownTitle.hide()
	else:
		$CardBackground/MarginContainer/VBoxContainer/CardTitle/UnknownTitle.show()

func _process(delta: float) -> void:
	if PlayerManager.is_in_resting_area:
		if !has_been_erased:
			$RichTextLabel.hide()
			$EraseCardButton.show()
		else:
			$RichTextLabel.show()
			$EraseCardButton.hide()
	else:
		$RichTextLabel.hide()
		$EraseCardButton.hide()

func _on_description_mouse_entered() -> void:
	$"../../..".can_scroll = false

func _on_description_mouse_exited() -> void:
	$"../../..".can_scroll = true

func _on_erase_card_button_pressed() -> void:
	if len(CardManager.player_deck) > 5 and PlayerManager.gold >= erase_cost:
		PlayerManager.gold -= erase_cost
		CardManager.player_deck.erase(which_card)
		has_been_erased = true
