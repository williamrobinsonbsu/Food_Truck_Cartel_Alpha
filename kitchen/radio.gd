extends StaticBody3D

signal shutter_door_button

func door_close():
	shutter_door_button.emit()
