extends Node2D

var max_health := 0.0
var health := max_health

var shield := 0.0

var weakening_effect := 0.0
var weakening_turns := 0
var poison_turns := 0
var bleeding_effect := 0.0
var bleeding_turns := 0
var ablaze_effect := 0.0
var ablaze_turns := 0
var dodge_effect := 1.0
var dodge_turns := 0

var base_dodge := 0.0
var base_defense := 0.0
var has_dodged := false
var defense_increment := 0.0
var defense_turns := 0
var base_damage := 0.0
var base_pure_damage := 0.0
var pure_damage_probability := 0.0
var defense_nullifier_turns := 0

var start_position := Vector2(0.0, 0.0)
var creature_type = ""

var creatures = [
	{
		"name": "small_slime",
		"display_name" : "Small Slime",
		"starting_shield": 0.0,
		"max_health": 20.0,
		"base_dodge": 4.0,
		"base_defense": 0.0,
		"base_damage": 10.0,
		"base_pure_damage": 0.0,
		"pure_damage_probability": 0.0,
		"attack_chance": 90.0,
		"special_effect": "none",
		"special_effect_chance": 15.0,
		"sprite": "small_slime",
	},
	{
		"name": "large_slime",
		"display_name" : "Large Slime",
		"starting_shield": 0.0,
		"max_health": 75.0,
		"base_dodge": 2.0,
		"base_defense": 3.0,
		"base_damage": 15.0,
		"base_pure_damage": 5.0,
		"pure_damage_probability": 5.0,
		"attack_chance": 75.0,
		"special_effect": "none",
		"special_effect_chance": 15.0,
		"sprite": "large_slime",
	},
	{
		"name": "spiderling",
		"display_name" : "Spiderling",
		"starting_shield": 0.0,
		"max_health": 30.0,
		"base_dodge": 8.0,
		"base_defense": 0.0,
		"base_damage": 10.0,
		"base_pure_damage": 0.0,
		"pure_damage_probability": 0.0,
		"attack_chance": 90.0,
		"special_effect": "poison",
		"special_effect_chance": 15.0,
		"sprite": "spiderling",
	},
	{
		"name": "spider",
		"display_name" : "Spider",
		"starting_shield": 0.0,
		"max_health": 50.0,
		"base_dodge": 4.0,
		"base_defense": 1.0,
		"base_damage": 10.0,
		"base_pure_damage": 5.0,
		"pure_damage_probability": 0.05,
		"attack_chance": 80.0,
		"special_effect": "poison",
		"special_effect_chance": 35.0,
		"sprite": "spider",
	},
	{
		"name": "spider_mother",
		"display_name" : "Spider Mother",
		"starting_shield": 15.0,
		"max_health": 100.0,
		"base_dodge": 1.0,
		"base_defense": 5.0,
		"base_damage": 15.0,
		"base_pure_damage": 10.0,
		"pure_damage_probability": 0.10,
		"attack_chance": 50.0,
		"special_effect": "poison",
		"special_effect_chance": 50.0,
		"sprite": "spider_mother",
	},
	{
		"name": "goblin",
		"display_name" : "Goblin",
		"starting_shield": 0.0,
		"max_health": 50.0,
		"base_dodge": 2.0,
		"base_defense": 5.0,
		"base_damage": 10.0,
		"base_pure_damage": 15.0,
		"pure_damage_probability": 0.10,
		"attack_chance": 85.0,
		"special_effect": "bleed",
		"special_effect_chance": 5.0,
		"sprite": "goblin",
	},
	{
		"name": "armored_goblin",
		"display_name" : "Armored Goblin",
		"starting_shield": 25.0,
		"max_health": 50.0,
		"base_dodge": 0.0,
		"base_defense": 10.0,
		"base_damage": 15.0,
		"base_pure_damage": 15.0,
		"pure_damage_probability": 0.15,
		"attack_chance": 85.0,
		"special_effect": "bleed",
		"special_effect_chance": 15.0,
		"sprite": "armored_goblin",
	},
]

var bosses = [
	{
		"name": "goblin_king",
		"display_name" : "Goblin King",
		"starting_shield": 250.0,
		"max_health": 500.0,
		"base_dodge": 5.0,
		"base_defense": 10.0,
		"base_damage": 25.0,
		"base_pure_damage": 35.0,
		"pure_damage_probability": 0.25,
		"attack_chance": 75.0,
		"special_effect": "king",
		"special_effect_chance": 75.0,
		"sprite": "goblin_king",
	},
	{
		"name": "blazing_breach",
		"display_name" : "Blazing Breach",
		"starting_shield": 0.0,
		"max_health": 300.0,
		"base_dodge": 15.0,
		"base_defense": 0.0,
		"base_damage": 25.0,
		"base_pure_damage": 10.0,
		"pure_damage_probability": 0.25,
		"attack_chance": 90.0,
		"special_effect": "ablaze",
		"special_effect_chance": 65.0,
		"sprite": "blazing_breach",
	},
	{
		"name": "the_ironclad",
		"display_name" : "The Ironclad",
		"starting_shield": 0.0,
		"max_health": 600.0,
		"base_dodge": 0.0,
		"base_defense": 15.0,
		"base_damage": 30.0,
		"base_pure_damage": 60.0,
		"pure_damage_probability": 0.5,
		"attack_chance": 33.3,
		"special_effect": "none",
		"special_effect_chance": 0.0,
		"sprite": "the_ironclad",
	},
]
""" [removed]
{
	"name": "the_disease_wanderer",
	"display_name" : "The Plague",
	"starting_shield": 100.0,
	"max_health": 500.0,
	"base_dodge": 5.0,
	"base_defense": 5.0,
	"base_damage": 25.0,
	"base_pure_damage": 20.0,
	"pure_damage_probability": 0.2,
	"attack_chance": 50.0,
	"special_effect": "disease",
	"special_effect_chance": 66.6,
	"sprite": "the_disease_wanderer",
},
"""


var creature_data = {
	"name": null,
	"display_name" : null,
	"starting_shield": null,
	"max_health": null,
	"base_dodge": null,
	"base_defense": null,
	"base_damage": null,
	"base_pure_damage": null,
	"pure_damage_probability": null,
	"attack_chance": null,
	"special_effect": null,
	"special_effect_chance": null,
	"sprite": null,
}

var is_player_hovering := false

"""
var card_functions := {
	"burst": burst(),
	"slash": slash(),
	"heal": heal(),
	"shield": spell_shield(),
	"incinerate": incinerate(),
	"ablaze": ablaze(),
	"distort": distort(),
	"extinguish": extinguish(),
	"boost_dexterity": boost_dexterity(),
	"explosion": explosion(),
	"magic_missle": magic_missle(),
	"obliterate": obliterate(),
	"weaken": weaken(),
	"greater_shield": greater_shield(),
	"regrowth": regrowth(),
	"blood_shield": blood_shield(),
	"shield_blade": shield_blade(),
	"superior_shield_blade": superior_shield_blade(),
	"regret": regret(),
	"stab": stab(),
	"stance": stance(),
	"shield_trade": shield_trade(),
	"defense_trade": defense_trade(),
	"strengthen": strengthen(),
	"steel_fist": steel_fist(),
}
"""

var effect_icon_load = preload("res://scenes/effect_icon.tscn")

var sprite_push := 0.0

var is_boss_type := false

func _ready() -> void:
	add_to_group("turn_affected_entity")
	
	for i in range(len(bosses)):
		if bosses[i]["name"] == creature_type:
			creature_data = bosses[i]
			is_boss_type = true
	for i in range(len(creatures)):
		if creatures[i]["name"] == creature_type:
			creature_data = creatures[i]
			is_boss_type = false
	
	
	$EntityName.text = str(creature_data["display_name"])
	#print(creature_data["sprite"])
	$EntityAnimation.play(creature_data["sprite"])
	$EntityAnimation.frame += randi_range(0, 3)
	if is_boss_type:
		$EntityAnimation.position.y -= 128.0
	max_health = creature_data["max_health"]
	health = max_health
	shield = creature_data["starting_shield"]
	base_dodge = creature_data["base_dodge"]
	base_defense = creature_data["base_defense"]
	base_damage = creature_data["base_damage"]
	base_pure_damage = creature_data["base_pure_damage"]
	pure_damage_probability = creature_data["pure_damage_probability"]
	$HealthBar.custom_minimum_size.x = max_health*2
	if $HealthBar.custom_minimum_size.x > 800:
		$HealthBar.custom_minimum_size.x = 800
	$HealthBar.size.x = max_health*2
	if $HealthBar.size.x > 800:
		$HealthBar.size.x = 800
	if is_boss_type:
		$HealthBar.size.y = 15.0
	$HealthBar.position.x = -$HealthBar.custom_minimum_size.x/2
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	$ShieldBar.custom_minimum_size.x = $HealthBar.custom_minimum_size.x/2
	$ShieldBar.size.x = max_health
	if is_boss_type:
		$ShieldBar.size.y = 7.5
	$ShieldBar.position.x = -$HealthBar.custom_minimum_size.x/2
	$ShieldBar.position.y = $HealthBar.position.y + 25
	$ShieldBar.max_value = max_health/2
	$ShieldBar.value = shield
	start_position = position
	$HealthBar/RichTextLabel.text = "[color=#EF0730]" + str(snapped(health, 0.1)) + "/" + str(max_health)
	$HealthBar/RichTextLabel.position.x = $HealthBar.size.x + 5
	if is_boss_type:
		start_position.x -= 250.0
		position = start_position
	EntityManager.level_entities.append(self)
	
	var pos_incr = 0
	for i in range(9):
		var tmp_effect_icon = effect_icon_load.instantiate()
		tmp_effect_icon.id = i
		tmp_effect_icon.scale = Vector2(0.2, 0.2)
		tmp_effect_icon.position.y = $Marker2D.position.y
		tmp_effect_icon.position.x = $Marker2D.position.x + pos_incr*25
		tmp_effect_icon.is_enabled = false
		get_node("EffectsList").add_child(tmp_effect_icon)
		if i == 2 or i == 6 or i == 3 or i == 1 or i == 8:
			tmp_effect_icon.show()
			pos_incr += 1
		else:
			tmp_effect_icon.hide()

func kill():
	EntityManager.level_entities.erase(self)
	queue_free()

func process_turn():
	if health <= 0:
		kill()
	if shield > max_health/2:
		shield = max_health/2


	if dodge_turns > 0:
		$EffectsList.get_children()[2].is_enabled = true
		$EffectsList.get_children()[2].turns_left = dodge_turns
		$EffectsList.get_children()[2].effect_value = base_dodge*dodge_effect
		change_dodge_effect()
	else:
		$EffectsList.get_children()[2].is_enabled = false

	if dodge_effect > 10:
		dodge_effect = 10
	
	if weakening_turns > 0:
		$EffectsList.get_children()[6].is_enabled = true
		$EffectsList.get_children()[6].turns_left = weakening_turns
		descale_weaken_effect()
	else:
		$EffectsList.get_children()[6].is_enabled = false
	
	if creature_data["name"] == "blazing_breach":
		bleeding_turns = 0
	
	if bleeding_turns > 0:
		$EffectsList.get_children()[3].is_enabled = true
		$EffectsList.get_children()[3].turns_left = bleeding_turns
		apply_bleeding_damage()
	else:
		$EffectsList.get_children()[3].is_enabled = false
	
	if creature_data["name"] == "blazing_breach":
		ablaze_turns = 0
	
	if ablaze_turns > 0:
		$EffectsList.get_children()[1].is_enabled = true
		$EffectsList.get_children()[1].turns_left = ablaze_turns
		apply_flame_damage()
	else:
		$EffectsList.get_children()[1].is_enabled = false
	
	if defense_turns > 0:
		$EffectsList.get_children()[8].is_enabled = true
		$EffectsList.get_children()[8].turns_left = defense_turns
		$EffectsList.get_children()[8].effect_value = base_defense + defense_increment
		tick_defense()
	else:
		$EffectsList.get_children()[8].is_enabled = false
	
	refresh_effects()

	if defense_nullifier_turns > 0:
		tick_defense_nullifier()
	
	has_dodged = false

func refresh_effects():
	for i in $EffectsList.get_children():
		i.refresh()

func _process(delta: float) -> void:
	$HealthBar/RichTextLabel.text = "[color=#EF0730]" + str(snapped(health, 0.1)) + "/" + str(max_health)
	$EntityAnimation.position.x += sprite_push
	sprite_push = move_toward(sprite_push, 0, delta*5)
	$EntityAnimation.position.x = move_toward($EntityAnimation.position.x, 0, delta*15)
	
	$HealthBar.value = health
	$ShieldBar.value = shield
	position.x = move_toward(position.x, start_position.x, delta*5)
	position.y = move_toward(position.y, start_position.y, delta*5)
	
	var click_distance := 0.0
	var click_shift := 0.0
	if is_boss_type:
		click_distance = 500.0
		click_shift = -128.0
	else:
		click_distance = 50.0
	
	if Vector2(global_position.x, global_position.y + click_shift).distance_to(get_global_mouse_position()) <= 50 and PlayerManager.is_using_card:
		if Input.is_action_just_pressed("left_click") and PlayerManager.energy_left >= CardManager.actual_cards_display[PlayerManager.using_card]["cost"] and health > 0:
			if PlayerManager.using_card != "replicate":
				PlayerManager.relapso_card = PlayerManager.using_card
			for i in CardManager.spell_register:
				if CardManager.spell_register[i][1] == PlayerManager.using_card:
					if CardManager.spell_register[i][0] == false:
						CardManager.new_card_found_display(PlayerManager.using_card)
					CardManager.spell_register[i][0] = true
			PlayerManager.is_using_card = false
			if PlayerManager.using_card != "replicate":
				if PlayerManager.is_performing:
					process_card_effect(PlayerManager.using_card)
					PlayerManager.is_performing = false
				process_card_effect(PlayerManager.using_card)
			else:
				if PlayerManager.relapso_card != "":
					if PlayerManager.is_performing:
						process_card_effect(PlayerManager.relapso_card)
						PlayerManager.is_performing = false
					process_card_effect(PlayerManager.relapso_card)
				PlayerManager.relapso_card = ""
			#PlayerManager.hide_all_active_card_statuses()
			PlayerManager.current_card.reload_card()
			PlayerManager.energy_left -= CardManager.actual_cards_display[PlayerManager.using_card]["cost"]
			PlayerManager.using_card = ""
			CardManager.refresh_all_card_effects()

func process_card_effect(which):
	if which == "burst":
		burst()
	elif which == "slash":
		slash()
	elif which == "heal":
		heal()
	elif which == "shield":
		spell_shield()
	elif which == "incinerate":
		incinerate()
	elif which == "ablaze":
		ablaze()
	elif which == "distort":
		distort()
	elif which == "extinguish":
		extinguish()
	elif which == "boost_dexterity":
		boost_dexterity()
	elif which == "explosion":
		explosion()
	elif which == "magic_missle":
		magic_missle()
	elif which == "obliterate":
		obliterate()
	elif which == "weaken":
		weaken()
	elif which == "greater_shield":
		greater_shield()
	elif which == "regrowth":
		regrowth()
	elif which == "blood_shield":
		blood_shield()
	elif which == "shield_blade":
		shield_blade()
	elif which == "superior_shield_blade":
		superior_shield_blade()
	elif which == "regret":
		regret()
	elif which == "stab":
		stab()
	elif which == "stance":
		stance()
	elif which == "shield_trade":
		shield_trade()
	elif which == "defense_trade":
		defense_trade()
	elif which == "strengthen":
		strengthen()
	elif which == "defense_trade":
		defense_trade()
	elif which == "steel_fist":
		steel_fist()
	elif which == "worthy_shield":
		worthy_shield()
	elif which == "replicate":
		process_card_effect(PlayerManager.relapso_card)
	elif which == "slashfix":
		slashfix()
	elif which == "dexdupe":
		dexdupe()
	elif which == "perform":
		perform()
	elif which == "vampirism":
		vampirism()
	elif which == "greater_healing":
		greater_healing()
	elif which == "superior_healing":
		superior_healing()
	elif which == "resuscitate":
		resuscitate()
	

var generic_entity_load = preload("res://scenes/generic_entity.tscn")

func attack_player():
	if randi_range(1, 100) <= creature_data["attack_chance"]:
		sprite_push = -1.5 
		if randi_range(1, 100) <= creature_data["pure_damage_probability"]*100:
			PlayerManager.apply_damage(0, creature_data["base_pure_damage"]-randf_range(0, weakening_effect), false)
			if !PlayerManager.has_dodged:
				if creature_data["special_effect"] != "none":
					if randi_range(1, 100) <= creature_data["special_effect_chance"]:
						if creature_data["special_effect"] == "poison":
							add_special_effect_to_player("poison")
						elif creature_data["special_effect"] == "bleed":
							add_special_effect_to_player("bleed")
						elif creature_data["special_effect"] == "ablaze":
							add_special_effect_to_player("ablaze")
						elif creature_data["special_effect"] == "weaken":
							add_special_effect_to_player("weaken")
						elif creature_data["special_effect"] == "disease":
							var selection = randi_range(1, 3)
							if selection == 1:
								add_special_effect_to_player("poison")
							elif selection == 2:
								add_special_effect_to_player("weaken")
							elif selection == 3:
								add_special_effect_to_player("bleed")
						elif creature_data["special_effect"] == "king":
							add_special_effect_to_player("bleed")
							if randi_range(1, 100) <= 25 and get_node("/root/FightingMapArea").enemy_count < 6:
								get_node("/root/FightingMapArea").enemy_count += 1
								var tmpCreature = generic_entity_load.instantiate()
								tmpCreature.creature_type = "goblin"
								for i in range(len(creatures)):
									if tmpCreature.creatures[i]["name"] == tmpCreature.creature_type:
										tmpCreature.creature_data = tmpCreature.creatures[i]
								var rando_markers = get_node("/root/FightingMapArea/EnemyMarkers/").get_children()
								var selected_marker = randi_range(0, len(rando_markers)-1)
								while get_node("/root/FightingMapArea").busy_markers[selected_marker] != 0:
									selected_marker = randi_range(0, len(rando_markers)-1)
								get_node("/root/FightingMapArea").busy_markers[selected_marker] = 1
								var rando_marker = rando_markers[selected_marker]
								tmpCreature.position = rando_marker.position
								get_node("/root/FightingMapArea/Enemies").add_child(tmpCreature)
				
		else:
			PlayerManager.apply_damage(creature_data["base_damage"]-randf_range(0, weakening_effect), 0, true)
			if !PlayerManager.has_dodged:
				if creature_data["special_effect"] != "none":
					if randi_range(1, 100) <= creature_data["special_effect_chance"]:
						if creature_data["special_effect"] == "poison":
							add_special_effect_to_player("poison")
						elif creature_data["special_effect"] == "bleed":
							add_special_effect_to_player("bleed")
						elif creature_data["special_effect"] == "ablaze":
							add_special_effect_to_player("ablaze")
						elif creature_data["special_effect"] == "weaken":
							add_special_effect_to_player("weaken")
						elif creature_data["special_effect"] == "disease":
							var selection = randi_range(1, 3)
							if selection == 1:
								add_special_effect_to_player("poison")
							elif selection == 2:
								add_special_effect_to_player("weaken")
							elif selection == 3:
								add_special_effect_to_player("bleed")
						elif creature_data["special_effect"] == "king":
							add_special_effect_to_player("bleed")
							if randi_range(1, 100) <= 100 and get_node("/root/FightingMapArea").enemy_count < 6:
								get_node("/root/FightingMapArea").enemy_count += 1
								var tmpCreature = generic_entity_load.instantiate()
								tmpCreature.creature_type = "goblin"
								for i in range(len(creatures)):
									if tmpCreature.creatures[i]["name"] == tmpCreature.creature_type:
										tmpCreature.creature_data = tmpCreature.creatures[i]
								var rando_markers = get_node("/root/FightingMapArea/EnemyMarkers/").get_children()
								var selected_marker = randi_range(0, len(rando_markers)-1)
								while get_node("/root/FightingMapArea").busy_markers[selected_marker] != 0:
									selected_marker = randi_range(0, len(rando_markers)-1)
								get_node("/root/FightingMapArea").busy_markers[selected_marker] = 1
								var rando_marker = rando_markers[selected_marker]
								tmpCreature.position = rando_marker.position
								get_node("/root/FightingMapArea/Enemies").add_child(tmpCreature)

func add_special_effect_to_player(which_effect):
	if which_effect == "poison":
		PlayerManager.poison_turns += randi_range(1, 4)
	elif which_effect == "bleed":
		PlayerManager.bleeding_turns += randi_range(1, 4)
	elif which_effect == "ablaze":
		PlayerManager.ablaze_effect += randi_range(4, 5)
		PlayerManager.ablaze_turns += randi_range(1, 4)
	elif which_effect == "weaken":
		PlayerManager.weakening_effect += randi_range(2, 5)
		PlayerManager.weakening_turns += randi_range(1, 4)


var dodge_label_preload = preload("res://scenes/dodge_text.tscn")
var damage_label_preload = preload("res://scenes/damage_label.tscn")
func damage_entity(damage, pure_damage, can_dodge):
	
	if randi_range(1, 100) <= (base_dodge*dodge_effect) and can_dodge:
		has_dodged = true
		damage = 0
		var tmp_dodge_label = dodge_label_preload.instantiate()
		tmp_dodge_label.global_position = Vector2(randi_range(-35, 35), randi_range(-35, 35))
		add_child(tmp_dodge_label)
	else:
		if shield >= damage:
			shield -= damage
		else:
			damage -= shield
			shield = 0.0
			if defense_nullifier_turns <= 0:
				if weakening_effect < base_defense+defense_increment:
					damage -= randf_range(0.0, base_defense+defense_increment-weakening_effect)
			if damage < 0:
				damage = 0
			health -= damage
			var tmp_dmg_label = damage_label_preload.instantiate()
			tmp_dmg_label.amount = damage
			tmp_dmg_label.global_position = Vector2(randi_range(-35, 35), randi_range(-35, 35))
			add_child(tmp_dmg_label)
	
	health -= pure_damage
	if pure_damage > 0:
		var tmp_dmg_label = damage_label_preload.instantiate()
		tmp_dmg_label.amount = pure_damage
		tmp_dmg_label.global_position = Vector2(randi_range(-35, 35), randi_range(-35, 35))
		add_child(tmp_dmg_label)

func descale_weaken_effect():
	weakening_turns -= 1
	if weakening_turns <= 0:
		weakening_effect = 0
	
func change_dodge_effect():
	dodge_turns -= 1
	dodge_effect = dodge_effect * (dodge_turns) / (dodge_turns+1)
	if dodge_effect < 1:
		dodge_effect = 1.0
	if dodge_turns <= 0:
		dodge_effect = 1.0

func apply_flame_damage():
	ablaze_turns -= 1
	if bleeding_turns > 0:
		ablaze_turns -= 1
	damage_entity(0, ablaze_effect, false)
	if ablaze_turns <= 0:
		ablaze_effect = 0
	
func apply_bleeding_damage():
	bleeding_turns -= 1
	bleeding_effect = 0.1*health
	if poison_turns > 0:
		bleeding_effect += 0.05*health
	damage_entity(0, bleeding_effect, false)
	if bleeding_turns <= 0:
		bleeding_effect = 0

func tick_defense():
	defense_turns -= 1
	if defense_turns <= 0:
		defense_increment = 0

func tick_defense_nullifier():
	defense_nullifier_turns -= 1
	if defense_nullifier_turns <= 0:
		shield += base_defense+defense_increment

func apply_shield(amount):
	shield += amount
	if shield > max_health/2:
		shield = max_health/2

func apply_healing(amount):
	health += amount
	if health > max_health:
		health = max_health

func _on_area_2d_mouse_entered() -> void:
	is_player_hovering = true

func _on_area_2d_mouse_exited() -> void:
	is_player_hovering = false

func burst():
	sprite_push = 2.5
	has_dodged = false
	damage_entity(0, randi_range(3, 5), true)
	if !has_dodged:
		bleeding_turns += randi_range(0, 2)
func slash():
	sprite_push = 1.5
	if bleeding_turns > 0:
		damage_entity(randi_range(8, 10)+randi_range(3, 4), 0, true)
	else:
		damage_entity(randi_range(8, 10), 0, true)
func heal():
	apply_healing(randi_range(10, 15))
	bleeding_effect = 0
	bleeding_turns = 0
func spell_shield():
	apply_shield(randi_range(5, 10))
func incinerate():
	sprite_push = 1.0
	has_dodged = false
	damage_entity(0, 5, false)
	if !has_dodged:
		ablaze_turns += randi_range(3, 5)
		ablaze_effect += randi_range(2, 3)
func ablaze():
	ablaze_turns += randi_range(4, 9)
	ablaze_effect += randi_range(4, 5)
func distort():
	dodge_effect *= randf_range(1.1, 1.3)
	dodge_turns += randi_range(1, 3)
func extinguish():
	ablaze_effect = 0
	ablaze_turns = 0
func boost_dexterity():
	dodge_effect *= randf_range(1.4, 1.6)
	dodge_turns += randi_range(1, 3)
func explosion():
	sprite_push = 2.0
	damage_entity(0, randi_range(10, 15), false)
func magic_missle():
	sprite_push = 2.0
	damage_entity(0, randi_range(3, 4), false)
func obliterate():
	sprite_push = 2.0
	damage_entity(0, randi_range(0, 65), false)
func weaken():
	weakening_effect += randi_range(2, 5)
	weakening_turns += randi_range(3, 5)
func greater_shield():
	apply_shield(randi_range(15, 25))
func regrowth():
	apply_healing(randi_range(12, 15))
	weakening_effect += randi_range(2, 3)
	weakening_turns += randi_range(1, 3)
func blood_shield():
	sprite_push = 2.5
	has_dodged = false
	damage_entity(0, 15, false)
	if !has_dodged:
		PlayerManager.shield += 20
func shield_blade():
	sprite_push = 2.5
	damage_entity(PlayerManager.shield, 0, true)
	PlayerManager.shield = 0
func superior_shield_blade():
	sprite_push = 2.5
	damage_entity(2*PlayerManager.shield, 0, true)
	PlayerManager.shield = 0
func regret():
	sprite_push = 2.5
	damage_entity(0, 2*(PlayerManager.max_health-PlayerManager.health), false)
	weakening_effect += randi_range(2, 7)
	weakening_turns += randi_range(3, 5)
	PlayerManager.weakening_effect += randi_range(2, 7)
	PlayerManager.weakening_turns += randi_range(3, 5)
	PlayerManager.apply_damage(0, 10, false)
func stab():
	sprite_push = 2.0
	has_dodged = false
	damage_entity(0, randi_range(5, 8), false)
	if !has_dodged:
		bleeding_turns += randi_range(4, 6)
func stance():
	defense_turns += randi_range(3, 4)
	defense_increment += randi_range(1, 3)
func shield_trade():
	apply_healing(shield/2)
	shield /= 2
func defense_trade():
	defense_nullifier_turns += randi_range(2, 4)
func strengthen():
	base_defense += 2
func steel_fist():
	sprite_push = 1.0
	if PlayerManager.base_defense+PlayerManager.defense_increment > base_defense+defense_increment:
		damage_entity(0, abs((PlayerManager.base_defense+PlayerManager.defense_increment)-(base_defense+defense_increment)), false)
func worthy_shield():
	if health <= 0.5*max_health:
		shield *= 2
func slashfix():
	var base_damage := 2
	var loops := 1
	damage_entity(base_damage, 0, true)
	while has_dodged:
		loops += 1
		damage_entity(base_damage**loops, 0, true)
		if loops > 10:
			return
func dexdupe():
	dodge_effect *= 2
func perform():
	PlayerManager.is_performing = true
func vampirism():
	var applied_damage := randi_range(10, 15)
	damage_entity(applied_damage, 0, true)
	if !has_dodged:
		PlayerManager.apply_healing(applied_damage/2)
		bleeding_turns += randi_range(0, 6)
func greater_healing():
	apply_healing(randi_range(20, 30))
	bleeding_effect = 0
	bleeding_turns = 0
func superior_healing():
	apply_healing(randi_range(30, 50))
	bleeding_effect = 0
	bleeding_turns = 0
func resuscitate():
	health = max_health
	defense_increment += 5
	shield += 0.1*max_health
	bleeding_effect = 0
	bleeding_turns = 0
	ablaze_effect = 0
	ablaze_turns = 0
	weakening_effect = 0
	weakening_turns = 0
	
