extends PickedIngredient


var smoke := preload("res://ingredients/smoke_effect/smoke.tscn")
var is_smoking = false
func name():
	return "patty"


func add_smoke():
	var smoking = smoke.instantiate()
	add_child(smoking)
	smoking = smoke.instantiate()
