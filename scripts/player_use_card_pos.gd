extends Node2D


func _process(delta: float) -> void:
	if global_position.distance_to(get_global_mouse_position()) <= 100 and PlayerManager.is_using_card:
		if Input.is_action_just_pressed("left_click") and PlayerManager.energy_left >= CardManager.actual_cards_display[PlayerManager.using_card]["cost"]:
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
			process_card_effect(PlayerManager.using_card)
			PlayerManager.hide_all_active_card_statuses()
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


func burst():
	PlayerManager.has_dodged = false
	PlayerManager.apply_damage(0, randi_range(3, 5), false)
	if !PlayerManager.has_dodged: 
		PlayerManager.bleeding_turns += randi_range(0, 2)
func slash():
	if PlayerManager.bleeding_turns > 0:
		PlayerManager.apply_damage(randi_range(8, 10)+randi_range(3, 4), 0, true)
	else:
		PlayerManager.apply_damage(randi_range(8, 10), 0, true)
func heal():
	PlayerManager.apply_healing(randi_range(2, 8))
	PlayerManager.poison_turns = 0
	PlayerManager.bleeding_effect = 0
	PlayerManager.bleeding_turns = 0
func spell_shield():
	PlayerManager.apply_shield(randi_range(5, 10))
func incinerate():
	PlayerManager.has_dodged = false
	PlayerManager.apply_damage(0, 5, false)
	if !PlayerManager.has_dodged: 
		PlayerManager.ablaze_turns += randi_range(3, 5)
		PlayerManager.ablaze_effect += randi_range(2, 3)
func ablaze():
	PlayerManager.ablaze_turns += randi_range(4, 9)
	PlayerManager.ablaze_effect += randi_range(4, 5)
func distort():
	PlayerManager.dodge_effect *= randf_range(1.1, 1.3)
	PlayerManager.dodge_turns += randi_range(1, 3)
func extinguish():
	PlayerManager.ablaze_effect = 0
	PlayerManager.ablaze_turns = 0
func boost_dexterity():
	PlayerManager.dodge_effect *= randf_range(1.4, 1.6)
	PlayerManager.dodge_turns += randi_range(1, 3)
func explosion():
	PlayerManager.apply_damage(0, randi_range(10, 15), false)
func magic_missle():
	PlayerManager.apply_damage(0, randi_range(3, 4), false)
func obliterate():
	PlayerManager.apply_damage(0, randi_range(0, 65), false)
func weaken():
	PlayerManager.weakening_effect += randi_range(2, 5)
	PlayerManager.weakening_turns += randi_range(3, 5)
func greater_shield():
	PlayerManager.apply_shield(randi_range(15, 25))
func regrowth():
	PlayerManager.apply_healing(randi_range(3, 8))
	PlayerManager.poison_turns = 0
	PlayerManager.weakening_effect += randi_range(2, 3)
	PlayerManager.weakening_turns += randi_range(1, 3)
func blood_shield():
	PlayerManager.apply_damage(0, 15, false)
	if !PlayerManager.has_dodged: 
		PlayerManager.shield += 20
func shield_blade():
	PlayerManager.apply_damage(PlayerManager.shield, 0, true)
	PlayerManager.shield = 0
func superior_shield_blade():
	PlayerManager.apply_damage(2*PlayerManager.shield, 0, true)
	PlayerManager.shield = 0
func regret():
	PlayerManager.apply_damage(0, (PlayerManager.health)/5, false)
func stab():
	PlayerManager.has_dodged = false
	PlayerManager.apply_damage(0, randi_range(5, 8), false)
	if !PlayerManager.has_dodged: 
		PlayerManager.bleeding_turns += randi_range(4, 6)
func stance():
	PlayerManager.defense_turns += randi_range(3, 4)
	PlayerManager.defense_increment += randi_range(1, 3)
func shield_trade():
	PlayerManager.apply_healing(PlayerManager.shield/2)
	PlayerManager.shield /= 2
func defense_trade():
	PlayerManager.defense_nullifier_turns += randi_range(1, 3)
func strengthen():
	PlayerManager.base_defense += 2
func steel_fist():
	PlayerManager.apply_damage(0, abs((PlayerManager.base_defense+PlayerManager.defense_increment)-(PlayerManager.base_defense+PlayerManager.defense_increment)), false)
func worthy_shield():
	if PlayerManager.health <= 0.5*PlayerManager.max_health:
		PlayerManager.shield *= 2
func slashfix():
	var base_damage := 2
	var loops := 1
	PlayerManager.apply_damage(base_damage, 0, true)
	while PlayerManager.has_dodged:
		loops += 1
		PlayerManager.apply_damage(base_damage**loops, 0, true)
		if loops > 10:
			return
func dexdupe():
	PlayerManager.dodge_effect *= 2
func perform():
	PlayerManager.is_performing = true
func vampirism():
	var applied_damage := randi_range(5, 10)
	PlayerManager.apply_damage(applied_damage, 0, true)
	if !PlayerManager.has_dodged:
		PlayerManager.bleeding_turns += randi_range(0, 6)
func greater_healing():
	var amount = randi_range(20, 30)
	PlayerManager.apply_healing(amount)
	PlayerManager.bleeding_effect = 0
	PlayerManager.bleeding_turns = 0
func superior_healing():
	var amount = randi_range(30, 50)
	PlayerManager.apply_healing(amount)
	PlayerManager.bleeding_effect = 0
	PlayerManager.bleeding_turns = 0
func resuscitate():
	PlayerManager.health = PlayerManager.max_health
	PlayerManager.defense_increment += 5
	PlayerManager.shield += 0.1*PlayerManager.max_health
	PlayerManager.bleeding_effect = 0
	PlayerManager.bleeding_turns = 0
	PlayerManager.ablaze_effect = 0
	PlayerManager.ablaze_turns = 0
	PlayerManager.weakening_effect = 0
	PlayerManager.weakening_turns = 0
	
