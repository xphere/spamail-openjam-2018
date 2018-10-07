extends Node2D

class_name Envelope

var label


func set_label(label : String) -> void:
	$Pivot/Letter/Label.text = label
	self.label = label


func kill() -> void:
	queue_free()


func set_category(category) -> void:
	var color = category.color

	$Pivot/Back.modulate = color
	$Pivot/Opened.modulate = color
	$Pivot/Closed.modulate = color
	$Pivot/Front.modulate = color
