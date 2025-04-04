extends Path2D
@onready var checkpoint_made: int = 10





func _on_check_1_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 0:
		checkpoint_made += 1


func _on_check_2_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 1:
		checkpoint_made += 1


func _on_check_3_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 2:
		checkpoint_made += 1


func _on_check_4_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 3:
		checkpoint_made += 1


func _on_check_5_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 4:
		checkpoint_made += 1


func _on_check_6_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 5:
		checkpoint_made += 1


func _on_check_7_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 6:
		checkpoint_made += 1


func _on_check_8_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 7:
		checkpoint_made += 1


func _on_check_9_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 8:
		checkpoint_made += 1


func _on_check_10_body_entered(_body: Node2D) -> void:
	if checkpoint_made == 9:
		checkpoint_made += 1


func _on_finish_line_body_entered(_body: Node2D) -> void:
	if checkpoint_made >= Globals.LapsNeedToBeMade:
		checkpoint_made = 0
		Globals.race_started = true
		Globals.lap_made.emit()
