extends RichTextLabel

var lifetime := 0.0
var amount := 0.0

func _ready() -> void:
	$".".text = "[color=red]-" + str(snapped(amount, 0.01)) + "[/color]"
	modulate = Color(1, 1, 1, 0.0)


func _process(delta: float) -> void:
	lifetime += delta*2
	position.y -= delta*(lifetime+2)*7
	var lifetime_func = 0.2274+1.9183*(lifetime)-1.4212*(lifetime**2)+0.25295*(lifetime**3)
	modulate = Color(1, 1, 1, lifetime_func)
	if lifetime >= 2.75:
		queue_free()
