extends StaticBody3D

signal shutter_door_button

func use():
	shutter_door_button.emit()
