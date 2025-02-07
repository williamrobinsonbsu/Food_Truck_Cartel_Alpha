extends StaticBody3D


func delete_item():
	return


func _on_area_3d_body_entered(body):
	if body.has_method("name") or body.has_method("slice_name"):
		body.queue_free()
	

func hover_name():
	$DiscardLabel/TrashcanLabelTimer.start()
	$DiscardLabel.show()

func _on_trashcan_label_timer_timeout():
	$DiscardLabel.hide()
