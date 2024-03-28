extends PickedIngredient

var cutted_lettuce = false

func cut_lettuce():
	if cutted_lettuce == false:
		$lettuce_whole.hide()
		$lettuce_slice.show()
		cutted_lettuce = true
		

