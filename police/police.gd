extends StaticBody3D

func despawn():
	$".".queue_free()
