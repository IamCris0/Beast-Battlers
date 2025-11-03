extends Control

@onready var male_button = $MaleButton
@onready var female_button = $FemaleButton
@onready var title_label = $TitleLabel

func _ready():
	# Configurar fuente
	setup_fonts()
	
	# Conectar señales
	male_button.pressed.connect(_on_male_selected)
	female_button.pressed.connect(_on_female_selected)
	
	# Animación de entrada
	animate_entrance()

func setup_fonts():
	var font = load("res://fonts/PressStart2P-Regular.ttf")
	title_label.add_theme_font_override("font", font)
	title_label.add_theme_font_size_override("font_size", 20)

func animate_entrance():
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func _on_male_selected():
	GameData.player_gender = "male"
	print("Género seleccionado: Masculino")
	_go_to_name_input()

func _on_female_selected():
	GameData.player_gender = "female"
	print("Género seleccionado: Femenino")
	_go_to_name_input()

func _go_to_name_input():
	# Animación de salida
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	
	# Cambiar a escena de nombre
	get_tree().change_scene_to_file("res://scenes/ui/name_input.tscn")
