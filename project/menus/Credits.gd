extends Control


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://menus/start_menu.tscn")


func _on_license_button_pressed():
	$CanvasLayer.visible = false
	$LicenseCanvasLayer.visible = true


func _on_engine_license_button_pressed():
	$EngineLicCanvasLayer.visible = true
	$LicenseCanvasLayer.visible = false


func _on_license_back_button_pressed():
	$LicenseCanvasLayer.visible = false
	$CanvasLayer.visible = true


func _on_engine_back_button_pressed():
	$EngineLicCanvasLayer.visible = false
	$LicenseCanvasLayer.visible = true
