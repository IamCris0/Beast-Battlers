extends CharacterBody2D

# Velocidad del jugador
const SPEED = 100.0

# Referencia al sprite
@onready var sprite = $PlayerSprite

func _ready():
	print("Jugador listo")
	# Por ahora usaremos el icono de Godot como placeholder
	# Temporal: hacer el sprite más pequeño
	sprite.scale = Vector2(0.5, 0.5)

func _physics_process(delta):
	# Obtener la dirección de movimiento
	var direction = Vector2.ZERO
	
	# Detectar las teclas presionadas
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	
	# Normalizar para que el movimiento diagonal no sea más rápido
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# Aplicar la velocidad
	velocity = direction * SPEED
	
	# Mover el personaje
	move_and_slide()
