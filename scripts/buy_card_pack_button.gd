extends Control

var has_been_used := false

func _process(delta: float) -> void:
	if has_been_used:
		$MarginContainer/BuyButton.text = "Bought!"
		$Label.text = ""
	else:
		$MarginContainer/BuyButton.text = "Buy card pack"
		$Label.text = str(CardManager.card_pack_price) + "g"


func _on_buy_button_pressed() -> void:
	if !has_been_used:
		if PlayerManager.gold >= CardManager.card_pack_price:
			has_been_used = true
			CardManager.add_random_cards_to_deck(randi_range(2, 4), true)
			PlayerManager.gold -= CardManager.card_pack_price
			CardManager.card_pack_price *= 2.0
