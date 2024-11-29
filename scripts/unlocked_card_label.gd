extends Label

var card_name := ""
var lifetime := 0.0

func _ready() -> void:
	modulate = Color(1, 1, 1, 0)
	$".".text = "Discovered new card: " + card_name + "!"


func _process(delta: float) -> void:
	lifetime += delta
	if lifetime <= 1:
		modulate = Color(1, 1, 1, lifetime)
	else:
		modulate = Color(1, 1, 1, 2-lifetime)
	position.y -= delta*5
	if lifetime > 3:
		queue_free()
