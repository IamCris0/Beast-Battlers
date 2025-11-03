extends Control

# Referencias a los botones
@onready var new_game_button = $ButtonContainer/NewGameButton
@onready var continue_button = $ButtonContainer/ContinueButton
@onready var exit_button = $ButtonContainer/ExitButton
@onready var title_label = $TitleLabel
@onready var button_container = $ButtonContainer

# Referencias de audio
@onready var music_player = $MusicPlayer
@onready var hover_sound = $HoverSound
@onready var click_sound = $ClickSound

# Referencia al fondo
@onready var background = $BackGround

func _ready():
	# Configurar fuente para todos los elementos
	setup_fonts()
	
	# Habilitar continuar si existe guardado
	continue_button.disabled = not GameData.has_save()
	
	# Conectar las señales de los botones
	new_game_button.pressed.connect(_on_new_game_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
	# Conectar sonidos de hover para cada botón
	new_game_button.mouse_entered.connect(_on_button_hover)
	continue_button.mouse_entered.connect(_on_button_hover)
	exit_button.mouse_entered.connect(_on_button_hover)
	
	# Iniciar animaciones
	animate_title()
	animate_buttons()
	
	# Iniciar música
	if music_player.stream:
		music_player.play()
	
	print("Menú principal cargado")

func setup_fonts():
	# Cargar la fuente
	var font = load("res://fonts/PressStart2P-Regular.ttf")
	
	# Configurar el título
	title_label.add_theme_font_override("font", font)
	title_label.add_theme_font_size_override("font_size", 28)
	title_label.add_theme_color_override("font_color", Color.WHITE)
	title_label.add_theme_color_override("font_outline_color", Color.BLACK)
	title_label.add_theme_constant_override("outline_size", 4)
	
	# Configurar botones
	for button in [new_game_button, continue_button, exit_button]:
		button.add_theme_font_override("font", font)
		button.add_theme_font_size_override("font_size", 16)
		button.custom_minimum_size = Vector2(300, 50)

func animate_title():
	# Animación de flotación del título
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(title_label, "position:y", title_label.position.y - 10, 1.5)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(title_label, "position:y", title_label.position.y + 10, 1.5)

func animate_buttons():
	# Aparecer los botones con fade in
	button_container.modulate.a = 0
	var tween = create_tween()
	tween.tween_property(button_container, "modulate:a", 1.0, 1.0)
	
	# Animación de escala al pasar el mouse
	for button in [new_game_button, continue_button, exit_button]:
		button.mouse_entered.connect(func(): _on_button_scale(button, true))
		button.mouse_exited.connect(func(): _on_button_scale(button, false))

func _on_button_scale(button: Button, hover: bool):
	var tween = create_tween()
	if hover:
		tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.2)
	else:
		tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.2)

func _on_button_hover():
	# Reproducir sonido de hover
	if hover_sound.stream:
		hover_sound.play()

func _on_new_game_pressed():
	print("Nueva partida iniciada")
	if click_sound.stream:
		click_sound.play()
	
	# Resetear datos
	GameData.reset_data()
	
	# Animación de salida
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	
	# Ir a selección de género
	get_tree().change_scene_to_file("res://scenes/ui/Gender_selection.tscn")

func _on_continue_pressed():
	print("Continuar partida")
	if click_sound.stream:
		click_sound.play()
	
	# Cargar datos
	if GameData.load_game():
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0.0, 0.5)
		await tween.finished
		
		get_tree().change_scene_to_file("res://scenes/world/World.tscn")

func _on_exit_pressed():
	print("Saliendo del juego...")
	if click_sound.stream:
		click_sound.play()
	
	# Animación antes de salir
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	
	get_tree().quit()
