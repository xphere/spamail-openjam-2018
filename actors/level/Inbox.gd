extends VBoxContainer

signal overflow()

export var messageScene : PackedScene
export var MAX_CAPACITY : int = 20


func add_message(subject: String) -> void:
	if get_child_count() >= MAX_CAPACITY:
		emit_signal("overflow")
		return

	var message = messageScene.instance()
	message.get_node("Label").text = subject
	add_child(message)
