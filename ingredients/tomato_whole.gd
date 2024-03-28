extends PickedIngredient

var cutted_tomato = false

func cut_lettuce():
	if cutted_tomato == false:
		$tomato_whole.hide()
		$tomato_slice.show()
		cutted_tomato = true
		

