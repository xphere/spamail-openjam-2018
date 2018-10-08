extends Area2D

signal wrong_category()

var current_category


func get_categories() -> Array:
	return $Categories.get_children()


func set_current_category(category_name: String) -> void:
	current_category = $Categories.get_node(category_name)
	$Selector.modulate = current_category.color


func _on_Sidebar_body_entered(body: PhysicsBody2D) -> void:
	if not body is Envelope:
		return

	if body.tainted:
		emit_signal("wrong_category")
		$Inbox.add_score(1)
	else:
		body.category.add_score(1)

	body.kill()
