extends StaticBody3D

func despawn():
	$".".queue_free()
	
func catch():
	$PoliceFront.show()
	$PoliceSide.hide()
