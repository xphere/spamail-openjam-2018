extends Node2D

class_name Envelope

var label


func set_label(label : String) -> void:
	$Pivot/Letter/Label.text = label
	self.label = label


func kill() -> void:
	queue_free()


func set_color(color : Color) -> void:
	$Pivot/Back.modulate = color
	$Pivot/Opened.modulate = color
	$Pivot/Closed.modulate = color
	$Pivot/Front.modulate = color
