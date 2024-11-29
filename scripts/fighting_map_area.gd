extends Node2D

var generic_entity_load = preload("res://scenes/generic_entity.tscn")

var busy_markers = [0, 0, 0, 0, 0, 0]

var enemy_count := 0

func _ready() -> void:
	$EndCombatButton/StillInCombatLabel.modulate[3] = 0
	CardManager.shuffle_deck()
	if !PlayerManager.is_in_boss_area:
		#print("Player not in boss area")
		if MapManager.current_combat_difficulty == 0:
			var rand_choice = randi_range(1, 100)
			if rand_choice <= 10:
				create_creature("small_slime")
			elif rand_choice > 10 and rand_choice <= 40:
				if randi_range(1, 100) <= 50:
					for i in range(3):
						create_creature("spiderling")
				else:
					for i in range(3):
						create_creature("small_slime")
			elif rand_choice > 40 and rand_choice <= 60:
				for i in range(randi_range(1, 2)):
					create_creature("spiderling")
				create_creature("spider")
			elif rand_choice > 60 and rand_choice <= 70:
				for i in range(randi_range(1, 2)):
					create_creature("spiderling")
				create_creature("goblin")
			elif rand_choice > 70 and rand_choice <= 75:
				create_creature("spider")
			elif rand_choice > 75 and rand_choice <= 80:
				create_creature("large_slime")
			elif rand_choice > 80 and rand_choice <= 95:
				create_creature("large_slime")
				for i in range(randi_range(1, 2)):
					create_creature("small_slime")
			else:
				create_creature("goblin")
		elif MapManager.current_combat_difficulty == 1:
			var rand_choice = randi_range(1, 100)
			if rand_choice <= 20:
				create_creature("armored_goblin")
			elif rand_choice > 20 and rand_choice <= 40:
				for i in range(randi_range(3, 4)):
					create_creature("goblin")
			elif rand_choice > 40 and rand_choice <= 50:
				for i in range(2):
					create_creature("armored_goblin")
			elif rand_choice > 50 and rand_choice <= 65:
				if randi_range(1, 100) <= 50:
					for i in range(4):
						create_creature("spiderling")
					create_creature("spider")
					if randi_range(1, 100) <= 10:
						create_creature("spider_mother")
				else:
					for i in range(2):
						create_creature("spiderling")
						create_creature("spider")
				create_creature("spider_mother")
			else:
				create_creature("armored_goblin")
				if randi_range(1, 100) <= 50:
					for i in range(randi_range(1, 2)):
						create_creature("goblin")
	else:
		#print("Player in boss area")
		var selection = randi_range(1, 100)
		if selection <= 33:
			create_boss("goblin_king")
		elif selection > 33 and selection <= 66:
			create_boss("the_ironclad")
		elif selection > 66 and selection <= 100:
			create_boss("blazing_breach")

func _process(delta: float) -> void:
	if TurnManager.is_turn_going:
		$EndTurnButton.hide()
	else:
		$EndTurnButton.show()
	
	if len(EntityManager.level_entities) < 1:
		$EndCombatButton.show()
	else:
		$EndCombatButton.hide()
	
	if $EndCombatButton/StillInCombatLabel.modulate[3] > 0:
		$EndCombatButton/StillInCombatLabel.modulate[3] -= delta
	
	if $EndTurnButton/StillInCombatLabel.modulate[3] > 0:
		$EndTurnButton/StillInCombatLabel.modulate[3] -= delta

func create_creature(type):
	enemy_count += 1
	var tmpCreature = generic_entity_load.instantiate()
	tmpCreature.creature_type = type
	var rando_markers = $EnemyMarkers.get_children()
	var selected_marker = randi_range(0, len(rando_markers)-1)
	while busy_markers[selected_marker] != 0:
		selected_marker = randi_range(0, len(rando_markers)-1)
	busy_markers[selected_marker] = 1
	var rando_marker = rando_markers[selected_marker]
	tmpCreature.position = rando_marker.position
	get_node("Enemies").add_child(tmpCreature)

func create_boss(type):
	enemy_count += 1
	var tmpCreature = generic_entity_load.instantiate()
	tmpCreature.creature_type = type
	var rando_markers = $EnemyMarkers.get_children()
	var selected_marker = randi_range(0, len(rando_markers)-1)
	selected_marker = 5
	busy_markers[selected_marker] = 1
	var rando_marker = rando_markers[selected_marker]
	tmpCreature.position = rando_marker.position
	get_node("Enemies").add_child(tmpCreature)

func _on_end_turn_button_pressed() -> void:
	if !TurnManager.is_turn_going:
		TurnManager.end_turn()
	else:
		$EndTurnButton/StillInCombatLabel.modulate = Color(1, 1, 1, 1)


func _on_end_combat_button_pressed() -> void:
	if len(EntityManager.level_entities) < 1:
		PlayerManager.gold += randf_range(10.0, 25.0)*enemy_count*((1+MapManager.current_combat_difficulty)**randi_range(1.5, 2.0))
		CardManager.shuffle_deck()
		EntityManager.level_entities = []
		var possible_cards = CardManager.cards.keys()
		for i in range(randi_range(2, 5)):
			var selected_card = possible_cards[randi_range(0, len(possible_cards)-1)]
			selected_card = possible_cards[randi_range(0, len(possible_cards)-1)]
			CardManager.player_deck.append(selected_card)
			
		if !PlayerManager.is_in_boss_area:
			get_tree().change_scene_to_file("res://scenes/map_select.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
	else:
		$EndCombatButton/StillInCombatLabel.modulate = Color(1, 1, 1, 1)
