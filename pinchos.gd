extends Area2D

signal tocado


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Jugador":
		tocado.emit()
