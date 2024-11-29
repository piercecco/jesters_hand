extends Node

var cards := {
	"burst" = {
		"display_name": "",
		"description": "Hits a creature for a 3-5 pure damage. Adds 0-2 turns of Bleeding status effect. Does nothing if used on environment."
	},
	"slash" = {
		"display_name": "",
		"description": "Hits a creature for 8-10 damage. Deals 3-4 bonus damage if the creature is bleeding. Does nothing if used on environment."
	},
	"heal" = {
		"display_name": "",
		"description": "Heals a creature for 10-20 points. Stops Bleeding status effect. Heals all creatures for 1-3 points if used on environment."
	},
	"shield" = {
		"display_name": "",
		"description": "Shield a creature for 5-10 points. Does nothing if used on environment."
	},
	"incinerate" = {
		"display_name": "",
		"description": "Sets a creature ablaze for 3-5 turns, dealing 2-3 damage each turn and dealing 5 damge on activation. Damages all creatures for 1-3 points if used on environment."
	},
	"ablaze" = {
		"display_name": "",
		"description": "Sets a creature ablaze for 4-9 turns, dealing 4-5 damage each turn. Sets all creatures ablaze for 2-4 turns if used on environment."
	},
	"distort" = {
		"display_name": "",
		"description": "Increments dodge change for a creature by 10%-30% for 1-3 turns if used on a creature. Increments dodge chance by 5%-10% for all creatures for 1-2 turns if used on environment."
	},
	"extinguish" = {
		"display_name": "",
		"description": "Instantly removes fire effect from all creatures if used on environment. If used on single creature extinguishes only it and heals it for 1-2 points if it was ablaze."
	},
	"boost_dexterity" = {
		"display_name": "",
		"description": "Increments dodge change for a creature by 40%-60% for 1-3 turns if used on a creature. Does nothing if used on environment."
	},
	"explosion" = {
		"display_name": "",
		"description": "Damages a single creature for 10-15 pure damage. Damages all creatures for 8-10 pure damage if used on environment."
	},
	"magic_missle" = {
		"display_name": "",
		"description": "Damages a single creature for 3-4 pure damage. Does nothing if used on environment."
	},
	"obliterate" = {
		"display_name": "",
		"description": "Damages a single creature for 15 pure damage. Does nothing if used on environment."
	},
	"weaken" = {
		"display_name": "",
		"description": "Inflicts a target creature with a weakening debuff that makes it deal 2-5 less damage each attack for 3-5 turns. Applies it to all creatures if used on environment."
	},
	"greater_shield" = {
		"display_name": "",
		"description": "Shield a creature for 15-25 points. Shields all creatures for 5-15 points if used on environment"
	},
	"regrowth" = {
		"display_name": "",
		"description": "Heals a target creature for 3-8 points, weakens it for 2-3 damage for 1-3 turns. Weakens all for 1-2 damage for 1-3 turns if used on environment."
	},
	"blood_shield" = {
		"display_name": "",
		"description": "Damages a creature for 10 points, giving it 20 points of shield. Inflicts the Bleeding status effect for 3-5 turns. Does nothing if used on environment."
	},
	"shield_blade" = {
		"display_name": "",
		"description": "Deals equal shield of the caster as damage to a creature. Remove shield. Does nothing if used on environment."
	},
	"superior_shield_blade" = {
		"display_name": "",
		"description": "Deals twice as much shield of the caster as pure damage to a creature. Remove shield. Does half the shield of the caster as damage to all creatures if used on environment."
	},
	"regret" = {
		"display_name": "",
		"description": "Deals twice as much missing health of the caster as pure damage to a creature. Deals equal damage as missing health to all creatures if used to environment. Deals 10 pure damage to caster."
	},
	"stab" = {
		"display_name": "",
		"description": "Deals 5-8 pure damage to a creature. Adds the Bleeding status effect for 4-6 turns. Does nothing if used on environment."
	},
	"stance" = {
		"display_name": "",
		"description": "Increments a creature's defense by 1-3 for 3-4 turns. Does nothing if used on environment."
	},
	"shield_trade" = {
		"display_name": "",
		"description": "Converts a creature's shield to half as much health. Does nothing if used on environment."
	},
	"defense_trade" = {
		"display_name": "",
		"description": "Nullifies a creature's defense for 2-4 turns in exchange for twice as much shield applied after defense is restored. Does nothing if used on environment."
	},
	"strengthen" = {
		"display_name": "",
		"description": "Increments a creature's defense by 2 for the duration of the combat. Increments all creatures defense by 2 for 5-8 turns if used on the environment."
	},
	"steel_fist" = {
		"display_name": "",
		"description": "Deals pure damage equal to the difference between user and target defense. Does nothing if used on environment."
	},
	"worthy_shield" = {
		"display_name": "",
		"description": "Doubles shield if health is less or equal than half of maximum health."
	},
	"replicate" = {
		"display_name": "",
		"description": "Copies the effects of the last card played."
	},
	"slashfix" = {
		"display_name": "",
		"description": "Tries attacking a target creature. If the attack misses, doubles the attack damage and tries again."
	},
	"dexdupe" = {
		"display_name": "",
		"description": "Duplicates incremental dodge chance."
	},
	"perform" = {
		"display_name": "",
		"description": "The next card's effects are applied twice."
	},
	"vampirism" = {
		"display_name": "",
		"description": "Deals 10-15 damage to a target creature, transfers the applied damage to the caster."
	},
	"greater_healing" = {
		"display_name": "",
		"description": "Heals the target creature for 20-30 points. Stops Bleeding status effect. Heals all creatures for 5-10 points if used on environment."
	},
	"superior_healing" = {
		"display_name": "",
		"description": "Heals the target creature for 30-50 points. Stops Bleeding status effect. Heals all creatures for 15-25 points if used on environment."
	},
	"resuscitate" = {
		"display_name": "",
		"description": "Completely heals the target creature for 30-50 points. Stops all negative status effects."
	},
}

var spell_register := {
	"IGNYUS": [false, null],
	"DEITOS": [false, null],
	"ABLAUS": [false, null],
	"FERIUS": [false, null],
	"UFNE": [false, null],
	"GOLDE": [false, null],
	"ETTO": [false, null],
	"ICRES": [false, null],
	"ATURNEN": [false, null],
	"YIEM": [false, null],
	"ILINIO": [false, null],
	"PETTEN": [false, null],
	"VERGO": [false, null],
	"LOR": [false, null],
	"CUSWO": [false, null],
	"TEIR": [false, null],
	"ABHE": [false, null],
	"LOIGE": [false, null],
	"GEISHO": [false, null],
	"CUREO": [false, null],
	"TEILO": [false, null],
	"LUFI": [false, null],
	"CAVEO": [false, null],
	"METINEA": [false, null],
	"ARREGA": [false, null],
	"LEISO": [false, null],
	"HIRKE": [false, null],
	"FOREIT": [false, null],
	"ENTHERES": [false, null],
	"OGHERES": [false, null],
	"AVALLON": [false, null],
	"JIETR": [false, null],
	"PRESTO": [false, null],
	"XERAM": [false, null],
	
}

var actual_cards_display = {
	"burst" = {
		"display_name": "Burst",
		"description": "10-15 pure damage on target creature. 0-2 turns of Bleeding status effect.",
		"cost": 1,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"slash" = {
		"display_name": "Slash",
		"description": "18-25 damage on target creature. +5-8 damage if the target creature is bleeding.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"heal" = {
		"display_name": "Heal",
		"description": "Heals a target creature for 10-15 points. Stops Bleeding.", #On environment: heals all for 1-3 points.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": true,
		"defend_effect": false,
	},
	"shield" = {
		"display_name": "Shield",
		"description": "Shield a target creature for 10-15 points.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"incinerate" = {
		"display_name": "Incinerate",
		"description": "Sets a target creature ablaze for 3-5 turns +10 damage on activation.", #On environment: damages all for 1-3 points.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": true,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"ablaze" = {
		"display_name": "Ablaze",
		"description": "Sets a target creature ablaze for 4-9 turns.", #On environment: sets all creatures ablaze for 2-4 turns.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": true,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"distort" = {
		"display_name": "Distort",
		"description": "+10%-30% dodge for 1-3 turns on target creature.", #On environment: +5%-10% dodge for all, 1-2 turns.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": true,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"extinguish" = {
		"display_name": "Extinguish",
		"description": "Removes Ablaze. Heals for 5-10 points.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": true,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": true,
		"defend_effect": false,
	},
	"boost_dexterity" = {
		"display_name": "Dexterity",
		"description": "+40%-60% dodge for 1-3 turns on target creature.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": true,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"explosion" = {
		"display_name": "Explosion",
		"description": "+35-65 damage on target creatures.", #On environment: damages all for 15-40 points.",
		"cost": 3,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"magic_missle" = {
		"display_name": "Magic Missle",
		"description": "+5-15 pure damage on target creature.",
		"cost": 1,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"obliterate" = {
		"display_name": "Obliterate",
		"description": "Deals up to 65 pure damage on target creature.",
		"cost": 4,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"weaken" = {
		"display_name": "Weaken",
		"description": "+2-5 turns of Weaken.", #On environment: applies to all creatures.",
		"cost": 3,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": true,
		"heal_effect": false,
		"defend_effect": false,
	},
	"greater_shield" = {
		"display_name": "Greater Shield",
		"description": "Shield a target creature for 35-50 points.", #On environment: shield all for 15-25 points",
		"cost": 3,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"regrowth" = {
		"display_name": "Regrowth",
		"description": "Heals a target creature for 3-8 points. +1-3 turns of Weaken.", #On environment: Weaken all for 1-3 turns.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": true,
		"heal_effect": true,
		"defend_effect": false,
	},
	"blood_shield" = {
		"display_name": "Blood Shield",
		"description": "+20 damage on target creature, applying 20 points of shield on caster. +3-5 turns of Bleeding on caster.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"shield_blade" = {
		"display_name": "Shield Blade",
		"description": "Deals equal shield points of the caster as damage to a creature. Remove shield.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"superior_shield_blade" = {
		"display_name": "Superior Shield Blade",
		"description": "2x caster's shield as damage to a target creature.", #On environment: x0.5 caster's shield points as damage to all. Remove shield.",
		"cost": 3,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"regret" = {
		"display_name": "Regret",
		"description": "Deals caster's missing HP as pure damage to target creature. Caster takes 10 pure damage.",
		"cost": 5,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": true,
		"heal_effect": false,
		"defend_effect": false,
	},
	"stab" = {
		"display_name": "Stab",
		"description": "Deals 5-15 pure damage to a target creature. +4-6 turns of Bleeding.",
		"cost": 1,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"stance" = {
		"display_name": "Stance",
		"description": "+2-5 defense for 3-4 turns on target creature.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": true,
	},
	"shield_trade" = {
		"display_name": "Shield Trade",
		"description": "Halves shield. Converts what has been taken in healing.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": true,
		"defend_effect": false,
	},
	"defense_trade" = {
		"display_name": "Defense Trade",
		"description": "Nullifies a target creature's defense for 2-4 turns. After turns end target creature gains 50 shield.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": true,
	},
	"strengthen" = {
		"display_name": "Stengthen",
		"description": "+2 defense for the duration of the combat.", #On environment: +2 defense to all for 5-8 turns.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": true,
	},
	"steel_fist" = {
		"display_name": "Steel Fist",
		"description": "Deals pure damage equal to the difference between user's and target creature's defense.",
		"cost": 1,
		"pure_damage_effect": true,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": true,
	},
	"worthy_shield" = {
		"display_name": "Worthy Shield",
		"description": "Doubles shield if health is less or equal than half of maximum health.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": true,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"replicate" = {
		"display_name": "Replicate",
		"description": "Copies the effects of the last card played.",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"slashfix" = {
		"display_name": "Slashfix",
		"description": "Tries attacking a target creature. If the attack misses, doubles the attack damage and tries again. Repeats at most 10 times",
		"cost": 1,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"dexdupe" = {
		"display_name": "Dexdupe",
		"description": "Duplicates incremental dodge chance.",
		"cost": 4,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": true,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"perform" = {
		"display_name": "Perform",
		"description": "The next card's effects are applied twice.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : false,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"vampirism" = {
		"display_name": "Vampirism",
		"description": "Deals 10-15 damage to a target creature, transfers the applied damage to the caster. Adds Bleeding for 0-6 turns.",
		"cost": 2,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": false,
		"defend_effect": false,
	},
	"greater_healing" = {
		"display_name": "Greater Healing",
		"description": "Heals the target creature for 20-30 points. Stops Bleeding status effect. Heals all creatures for 5-10 points if used on environment.",
		"cost": 3,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": true,
		"defend_effect": false,
	},
	"superior_healing" = {
		"display_name": "Superior Healing",
		"description": "Heals the target creature for 30-50 points. Stops Bleeding status effect. Heals all creatures for 15-25 points if used on environment.",
		"cost": 4,
		"pure_damage_effect": false,
		"ablaze_effect": false,
		"dodge_effect": false,
		"bleed_effect" : true,
		"poison_effect": false,
		"shield_effect": false,
		"weaken_effect": false,
		"heal_effect": true,
		"defend_effect": false,
	},
	"resuscitate" = {
		"display_name": "Resuscitate",
		"description": "Completely heals the target creature for 30-50 points. Stops all negative status effects. Increments Defense by 5.",
		"cost": 6,
		"pure_damage_effect": false,
		"ablaze_effect": true,
		"dodge_effect": true,
		"bleed_effect" : true,
		"poison_effect": true,
		"shield_effect": true,
		"weaken_effect": true,
		"heal_effect": true,
		"defend_effect": true,
	},
	
}

var effects_list = [
		"pure_damage_effect",
		"ablaze_effect",
		"dodge_effect",
		"bleed_effect" ,
		"poison_effect",
		"shield_effect",
		"weaken_effect",
		"heal_effect",
		"defend_effect"
		]

var effects_display_list = [
		"Pure Damage",
		"Ablaze",
		"Dodge",
		"Bleeding" ,
		"Poisoning",
		"Shield",
		"Weakening",
		"Healing",
		"Defense"
]

var effect_tooltips = {
	"pure_damage_effect": "Special type of damage that bypasses shield and is always guaranteed.",
	"ablaze_effect": "Deals damage over time and can be stopped with spells or by bleeding.",
	"dodge_effect": "Increments a creature dodge chance.",
	"bleed_effect" : "Deals damage over time. Higher damage if target is also poisoned.",
	"poison_effect": "Deals damage over time. Ticks faster if target is ablaze.",
	"shield_effect": "Extra health bar that lasts for the duration of the combat. Can be consumed for special attacks.",
	"weaken_effect": "Reduces damage dealt by a creature and its defense.",
	"heal_effect": "Increases the current health points of a creature.",
	"defend_effect": "Lowers the damage a creature takes.",
}

var player_deck = []
var avaliable_cards = []
var docked_cards := 0

var has_to_reload_all_cards := false



var card_pack_price := 10.0

func generate_register():
	#print(len(cards))
	#print(len(spell_register))
	for i in spell_register:
		spell_register[i][0] = false
	
	var cards_list = []
	for s in cards:
		cards_list.append(s)
	cards_list = shuffle_list(cards_list)
	var names_list = []
	for d in spell_register:
		names_list.append(d)
	for i in range(len(spell_register)):
		#if cards_list[i] == "slash" or cards_list[i] == "burst" or cards_list[i] == "stab":
		#	spell_register[names_list[i]][0] = true
		spell_register[names_list[i]][1] = cards_list[i]
	#print(spell_register)

func shuffle_list(arr):
	var used_indexes = []
	var resulting_arr = []
	while len(used_indexes) < len(cards):
		var used_index = randi_range(0, len(arr)-1)
		while used_index in used_indexes:
			used_index = randi_range(0, len(arr)-1)
		used_indexes.append(used_index)
		resulting_arr.append(arr[used_index])
	return resulting_arr

func create_player_deck():
	player_deck.append("slash")
	player_deck.append("slash")
	player_deck.append("burst")
	player_deck.append("stab")
	player_deck.append("shield")
	player_deck.append("heal")
	"""
	for i in range(6):
		player_deck.append("defense_trade")
	"""
	add_random_cards_to_deck(6, false)
	#add_random_cards_to_deck(56, true)
	#print(player_deck)

func add_random_cards_to_deck(amount, allow_repeating):
	var possible_cards = cards.keys()
	for i in range(amount):
		var selected_card = possible_cards[randi_range(0, len(possible_cards)-1)]
		if !allow_repeating:
			while selected_card in player_deck:
				selected_card = possible_cards[randi_range(0, len(possible_cards)-1)]
		player_deck.append(selected_card)
	

func shuffle_deck():
	has_to_reload_all_cards = true
	var tmp_deck = []
	var tmp_result = []
	tmp_deck = player_deck.duplicate()
	#print(tmp_deck)
	var is_looping = true
	while is_looping:
		for i in range(len(tmp_deck)):
			if tmp_deck[i] != null:
				is_looping = true
				break
			else:
				is_looping = false
		var selected = randi_range(0, len(tmp_deck)-1)
		if tmp_deck[selected] != null:
			tmp_result.append(tmp_deck[selected])
			tmp_deck[selected] = null
	#print(tmp_result)
	player_deck = tmp_result.duplicate()
	avaliable_cards = tmp_result.duplicate()
	docked_cards = len(avaliable_cards)
	update_all_cards()
	#print(player_deck)

func update_all_cards():
	var node_card = get_node("/root/FightingMapArea/PlayerGUI/CardsSelector/Cards")
	if node_card != null:
		for i in node_card.get_children():
			i.reload_card()

func new_card_found_display(card_name):
	var tmp_card_display_load = preload("res://scenes/unlocked_card_label.tscn")
	var tmp_card_display = tmp_card_display_load.instantiate()
	tmp_card_display.card_name = actual_cards_display[card_name]["display_name"]
	tmp_card_display.position = Vector2(300, 450)
	get_node("/root/FightingMapArea/").add_child(tmp_card_display)

func refresh_all_card_effects():
	for i in get_node("/root/FightingMapArea/PlayerGUI/CardsSelector/Cards").get_children():
		i.refresh_effect_list()
