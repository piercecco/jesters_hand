extends Control


var card_menu_load = preload("res://scenes/deck_menu_card.tscn")

var card_deck_shift := 0.0
var total_shift := 0

var can_scroll := true

func _ready() -> void:
	refresh_deck_menu()

func _process(delta: float) -> void:
	$ScrollBar.position.y = (float(total_shift)/len(CardManager.player_deck)/5)*180*85 + 50
	
	$MarginContainer.position.y = move_toward($MarginContainer.position.y, card_deck_shift, delta*60*35)
	
	
	if Input.is_action_just_pressed("scroll_down") and can_scroll and get_global_mouse_position().x < global_position.x+700:
		if total_shift <= round(len(CardManager.player_deck)/5)-1:
			total_shift += 1
			if PlayerManager.is_in_resting_area:
				card_deck_shift += -252.5
			else:
				card_deck_shift += -177.5
	elif Input.is_action_just_pressed("scroll_up") and can_scroll and get_global_mouse_position().x < global_position.x+700:
		if total_shift > 0:
			total_shift -= 1
			if PlayerManager.is_in_resting_area:
				card_deck_shift += 252.5
			else:
				card_deck_shift += 177.5

func refresh_deck_menu():
	card_deck_shift = 0
	
	if $MarginContainer/GridContainer.get_child_count() > 0:
		for n in $MarginContainer/GridContainer.get_children():
			$MarginContainer/GridContainer.remove_child(n)
			n.queue_free()
	
	for i in range(len(CardManager.player_deck)):
		var tmp_card = card_menu_load.instantiate()
		tmp_card.id = i
		get_node("MarginContainer/GridContainer").add_child(tmp_card)


func _on_scroll_down_button_pressed() -> void:
	if total_shift <= round(len(CardManager.player_deck)/5)-1:
		total_shift += 1
		if PlayerManager.is_in_resting_area:
			card_deck_shift += -252.5
		else:
			card_deck_shift += -177.5

func _on_scroll_up_button_pressed() -> void:
	if total_shift > 0:
		total_shift -= 1
		if PlayerManager.is_in_resting_area:
			card_deck_shift += 252.5
		else:
			card_deck_shift += 177.5
