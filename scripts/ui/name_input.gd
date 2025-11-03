extends Control

@onready var name_input = $NameLineEdit
@onready var confirm_button = $ConfirmButton
@onready var title_label = $TitleLabel
@onready var character_preview = $CharacterPreview

const MAX_NAME_LENGTH = 10

func _ready():
	setup_fonts()
	
	# Configurar LineEdit
	name_input.max_length = MAX_NAME_LENGTH
	name_input.placeholder_text = "Ingresa tu nombre"
	name_input.grab_focus()
	
	# Conectar señales
	confirm_button.pressed.connect(_on_confirm_pressed)
	name_input.text_submitted.connect(_on_name_submitted)
	
	# Mostrar preview del personaje según género
	update_character_preview()
	
	animate_entrance()

func setup_fonts():
	var font = load("res://fonts/PressStart2P-Regular.ttf")
	title_label.add_theme_font_override("font", font)
	title_label.add_theme_font_size_override("font_size", 18)
	
	confirm_button.add_theme_font_override("font", font)
	confirm_button.add_theme_font_size_override("font_size", 14)
	
	name_input.add_theme_font_override("font", font)
	name_input.add_theme_font_size_override("font_size", 16)

func animate_entrance():
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func update_character_preview():
	# Aquí cargarías el sprite correcto según el género
	# Por ahora usamos el icono temporal
	pass

func _on_confirm_pressed():
	_submit_name()

func _on_name_submitted(_text: String):
	_submit_name()

func _submit_name():
	var player_name = name_input.text.strip_edges()
	
	if player_name.length() < 2:
		print("Nombre muy corto")
		# Aquí podrías mostrar un mensaje de error
		return
	
	GameData.player_name = player_name
	print("Nombre del jugador: ", player_name)
	
	# Animación de salida
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	
	# Ir al mundo del juego
	get_tree().change_scene_to_file("res://scenes/world/World.tscn")
