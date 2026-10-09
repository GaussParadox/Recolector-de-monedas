extends Node2D

# Las nubes (nodos que empiezan por "Nube") avanzan despacio y reaparecen al salir.
const VELOCIDAD := 5.0


func _process(delta: float) -> void:
	for nube in get_children():
		if nube.name.begins_with("Nube"):
			nube.position.x += VELOCIDAD * nube.scale.x * delta
			if nube.position.x > 790:
				nube.position.x = -70
