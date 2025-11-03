extends Control

# Referencias a los botones
@onready var new_game_button = $ButtonContainer/NewGameButton
@onready var continue_button = $ButtonContainer/ContinueButton
@onready var exit_button = $ButtonContainer/ExitButton

func _ready():
	# Conectar las señales de los botones
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
	# Desactivar continuar si no hay partida guardada
	continue_button.disabled = true
	
	print("Menú principal cargado")

func _on_new_game_pressed():
	print("Nueva partida iniciada")
	# Aquí cargaremos la escena del mundo más adelante
	# get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func _on_continue_pressed():
	print("Continuar partida")
	# Aquí cargaremos la partida guardada

func _on_exit_pressed():
	print("Saliendo del juego...")
	get_tree().quit()
