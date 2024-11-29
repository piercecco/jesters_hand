extends Control

@onready var effect_icon_load = preload("res://scenes/effect_icon.tscn")

func _ready() -> void:
	
	$MarginContainer/VBoxContainer/MarginContainer/HealthBar.max_value = PlayerManager.max_health
	$MarginContainer/VBoxContainer/MarginContainer/HealthBar.value = PlayerManager.health
	$MarginContainer/VBoxContainer/MarginContainer2/ShieldBar.max_value = PlayerManager.max_health/2
	
	var pos_incr = 0
	for i in range(9):
		var tmp_effect_icon = effect_icon_load.instantiate()
		tmp_effect_icon.id = i
		tmp_effect_icon.is_enabled = false
		tmp_effect_icon.scale *= 0.25
		tmp_effect_icon.position.x += 25
		tmp_effect_icon.position.y = 35*pos_incr
		get_node("EffectsContainer").add_child(tmp_effect_icon)
		var acceptable_indexed = [1, 2, 3, 4, 6, 8]
		if i in acceptable_indexed:
			tmp_effect_icon.show()
			pos_incr += 1
		else:
			tmp_effect_icon.hide()

func _process(delta: float) -> void:
	if PlayerManager.health < 0:
		$DeathScreenMenu.show()
		$DeathBlur.show()
	else:
		$DeathScreenMenu.hide()
		$DeathBlur.hide()
		
	
	if PlayerManager.dodge_turns > 0:
		$EffectsContainer.get_children()[2].is_enabled = true
		$EffectsContainer.get_children()[2].turns_left = PlayerManager.dodge_turns
		$EffectsContainer.get_children()[2].effect_value = PlayerManager.base_dodge*PlayerManager.dodge_effect
	else:
		$EffectsContainer.get_children()[2].is_enabled = false

	if PlayerManager.weakening_turns > 0:
		$EffectsContainer.get_children()[6].is_enabled = true
		$EffectsContainer.get_children()[6].turns_left = PlayerManager.weakening_turns
	else:
		$EffectsContainer.get_children()[6].is_enabled = false
	
	if PlayerManager.bleeding_turns > 0:
		$EffectsContainer.get_children()[3].is_enabled = true
		$EffectsContainer.get_children()[3].turns_left = PlayerManager.bleeding_turns
	else:
		$EffectsContainer.get_children()[3].is_enabled = false
	
	if PlayerManager.ablaze_turns > 0:
		$EffectsContainer.get_children()[1].is_enabled = true
		$EffectsContainer.get_children()[1].turns_left = PlayerManager.ablaze_turns
	else:
		$EffectsContainer.get_children()[1].is_enabled = false
	
	if PlayerManager.defense_turns > 0 or PlayerManager.defense_nullifier_turns > 0:
		$EffectsContainer.get_children()[8].is_enabled = true
		if PlayerManager.defense_nullifier_turns <= 0:
			$EffectsContainer.get_children()[8].is_defense_nullifier = false
			$EffectsContainer.get_children()[8].turns_left = PlayerManager.defense_turns
		else:
			$EffectsContainer.get_children()[8].is_defense_nullifier = true
			$EffectsContainer.get_children()[8].turns_left = PlayerManager.defense_nullifier_turns
		$EffectsContainer.get_children()[8].effect_value = PlayerManager.base_defense + PlayerManager.defense_increment
	else:
		$EffectsContainer.get_children()[8].is_enabled = false
	
	if PlayerManager.poison_turns > 0:
		$EffectsContainer.get_children()[4].is_enabled = true
		$EffectsContainer.get_children()[4].turns_left = PlayerManager.poison_turns
	else:
		$EffectsContainer.get_children()[4].is_enabled = false
	

	for i in $EffectsContainer.get_children():
		i.refresh()
	
	var stats_text = $MarginContainer/VBoxContainer/MarginContainer3/HBoxContainer/VBoxContainer/stats
	stats_text.text = "Dodge chance: " + str(snapped((PlayerManager.base_dodge*PlayerManager.dodge_effect), 0.1)) + "%\n"
	stats_text.text += "Ablaze turns: " + str(PlayerManager.ablaze_turns) + "\n"
	stats_text.text += "Bleeding turns: " + str(PlayerManager.bleeding_turns) + "\n"
	stats_text.text += "Poison turns: " + str(PlayerManager.poison_turns) + "\n"
	stats_text.text += "Weakened turns: " + str(PlayerManager.weakening_turns) + "\n"
	if PlayerManager.defense_nullifier_turns <= 0:
		stats_text.text += "Defense: " + str(PlayerManager.base_defense+PlayerManager.defense_increment) + "\n"
	else:
		stats_text.text += "Defense: 0\n"
	
	if PlayerManager.defense_nullifier_turns > 0:
		stats_text.text += "Defense nullifier turns left: " + str(PlayerManager.defense_nullifier_turns) + "\n"
	
	$MarginContainer/VBoxContainer/MarginContainer2/ShieldBar.value = PlayerManager.shield
	$MarginContainer/VBoxContainer/MarginContainer/HealthBar.value = PlayerManager.health
	$MarginContainer/VBoxContainer/MarginContainer/HealthBar/HealthLabel.text = str(int(PlayerManager.health)) + "/" + str(int(PlayerManager.max_health))
	$MarginContainer/VBoxContainer/MarginContainer2/ShieldBar/ShieldLabel.text = str(int(PlayerManager.shield)) + "/" + str(int(PlayerManager.max_health/2))

func hide_all_active_card_statuses():
	$CardsSelector.hide_active_labels()
