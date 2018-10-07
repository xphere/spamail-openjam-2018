extends Area2D

var current_category


func get_categories() -> Array:
	return $Categories.get_children()


func set_current_category(category_name: String) -> void:
	current_category = $Categories.get_node(category_name)
	$Selector.modulate = current_category.color
