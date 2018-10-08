extends VBoxContainer

signal overflow()

export var messageScene : PackedScene
export var MAX_CAPACITY : int = 20


func add_message(from: String, subject: String) -> void:
	var message = messageScene.instance()
	message.set_content(from, subject)
	add_child(message)

	if get_child_count() > MAX_CAPACITY:
		emit_signal("overflow")
