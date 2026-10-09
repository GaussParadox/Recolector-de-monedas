extends Area2D

signal recogida


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jugador":
		recogida.emit()
		queue_free()
