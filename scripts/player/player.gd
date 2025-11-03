extends CharacterBody2D

# Velocidad del jugador
const SPEED = 100.0

# Referencia al sprite
@onready var sprite = $PlayerSprite

func _ready():
	print("Jugador listo")
	print("Nombre: ", GameData.player_name)
	print("Género: ", GameData.player_gender)
	
	# Cargar posición guardada si existe
	position = GameData.player_position
	
	sprite.scale = Vector2(0.8, 0.8)
	sprite.modulate = Color(1, 1, 1, 1)

func _physics_process(_delta):
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
	GameData.player_position = position
	# Aplicar la velocidad
	velocity = direction * SPEED
	
	# Mover el personaje
	move_and_slide()
	
	func _input(event):
	if event.is_action_pressed("ui_accept"):  # Tecla Enter/Space
		GameData.save_game()
		print("¡Juego guardado!")
		
	# Debug: imprimir la posición para verificar movimiento
	if direction != Vector2.ZERO:
		print("Posición actual: ", position)
