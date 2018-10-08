extends ColorRect

var current : int = 0
var max_capacity : int = 20


func add_score(value: int) -> void:
	current += value
	$Label.text = "%d / %d" % [ current, max_capacity ]
