extends Control


@export var target_scene_path: String
var loading_status: int


func _process(_delta) -> void:
	if target_scene_path != null:
		loading_status = ResourceLoader.load_threaded_get_status(target_scene_path)
		
		match loading_status:
			ResourceLoader.THREAD_LOAD_LOADED:
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(target_scene_path))
			ResourceLoader.THREAD_LOAD_FAILED:
				print("Resource load error")


func set_scene(path):
	target_scene_path = path
	ResourceLoader.load_threaded_request(target_scene_path)
