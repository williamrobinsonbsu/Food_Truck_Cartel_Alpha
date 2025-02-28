extends Control

const _LABEL_TEXT_META_KEY := "label_text"

@onready var _tree : Tree = %Tree
# Called when the node enters the scene tree for the first time.
func _ready():
	var root := _tree.create_item()
	var components_item := _tree.create_item(root)
	components_item.set_text(0, "Components")
	for component in Engine.get_copyright_info():
		var entry := _tree.create_item(components_item)
		entry.set_text(0, component.name)
		var text := ""
		for part in component.parts:
			for copyright in part.copyright:
				text += "Copyright %s\n" % copyright
			text += "License: " + part.license
		entry.set_meta(_LABEL_TEXT_META_KEY, text)
	var licenses_item := _tree.create_item(root)
	licenses_item.set_text(0, "Licenses")
	for license in Engine.get_license_info():
		var entry := _tree.create_item(licenses_item)
		entry.set_text(0, license)
		entry.set_meta(_LABEL_TEXT_META_KEY, Engine.get_license_info()[license])




func _on_tree_item_selected():
	var _selection = _tree.get_selected()
	if _selection.has_meta(_LABEL_TEXT_META_KEY):
		%Label.text = _selection.get_meta(_LABEL_TEXT_META_KEY)
	else:
		%Label.text = ""
