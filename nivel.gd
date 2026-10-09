extends Node2D

var monedas := 0
var total := 0
var vidas := 3
var inicio := Vector2.ZERO

@onready var jugador := $Jugador
@onready var texto_monedas := $HUD/Margen/Fila/Monedas
@onready var barra_vidas := $HUD/Margen/Fila/Vidas
@onready var mensaje := $HUD/Mensaje


func _ready() -> void:
	inicio = jugador.position
	for moneda in $Monedas.get_children():
		moneda.recogida.connect(_on_moneda_recogida)
		total += 1
	for peligro in $Peligros.get_children():
		peligro.tocado.connect(perder_vida, CONNECT_DEFERRED)
	actualizar_hud()


func _physics_process(_delta: float) -> void:
	if jugador.position.y > 300:
		perder_vida()


func _on_moneda_recogida() -> void:
	monedas += 1
	actualizar_hud()
	if monedas == total:
		mensaje.show()
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://menu.tscn")


func perder_vida() -> void:
	vidas -= 1
	jugador.position = inicio
	jugador.velocity = Vector2.ZERO
	actualizar_hud()
	if vidas <= 0:
		get_tree().change_scene_to_file("res://menu.tscn")


func actualizar_hud() -> void:
	texto_monedas.text = "Monedas: %d / %d" % [monedas, total]
	barra_vidas.value = vidas
