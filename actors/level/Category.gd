extends ColorRect

var score = 0


func add_score(value: int) -> void:
	score += value
	$Label.text = "%d" % score
