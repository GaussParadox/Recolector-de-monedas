extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -360.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("caminar")
		$AnimatedSprite2D.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("quieto")

	move_and_slide()

	# --- Reto opcional: empujar cuerpos rigidos (no afecta al nivel principal) ---
	for i in get_slide_collision_count():
		var choque := get_slide_collision(i)
		var cuerpo = choque.get_collider()
		if cuerpo is RigidBody2D:
			cuerpo.apply_central_impulse(-choque.get_normal() * 20.0)
