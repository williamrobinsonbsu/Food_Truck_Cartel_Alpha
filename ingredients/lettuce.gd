extends RigidBody3D

var cutted_lettuce = false

func cut_lettuce():
	if cutted_lettuce == false:
		$"Raw Lettuce".hide()
		$"Cut Lettuce".show()
		cutted_lettuce = true
