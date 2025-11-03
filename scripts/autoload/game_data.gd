extends Node

# Datos del jugador
var player_name: String = ""
var player_gender: String = "male"  # "male" o "female"
var current_save_slot: int = 1

# Ruta del archivo de guardado
const SAVE_PATH = "user://savegame.save"

# Datos del juego
var player_position: Vector2 = Vector2(576, 324)
var play_time: float = 0.0
var pokedex_caught: int = 0

func _ready():
	print("GameData inicializado")

# Guardar partida
func save_game() -> bool:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if save_file == null:
		print("Error al crear archivo de guardado")
		return false
	
	var save_data = {
		"player_name": player_name,
		"player_gender": player_gender,
		"player_position": {"x": player_position.x, "y": player_position.y},
		"play_time": play_time,
		"pokedex_caught": pokedex_caught
	}
	
	var json_string = JSON.stringify(save_data)
	save_file.store_line(json_string)
	save_file.close()
	
	print("Partida guardada exitosamente")
	return true

# Cargar partida
func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No existe archivo de guardado")
		return false
	
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if save_file == null:
		print("Error al abrir archivo de guardado")
		return false
	
	var json_string = save_file.get_line()
	save_file.close()
	
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if parse_result != OK:
		print("Error al parsear JSON")
		return false
	
	var save_data = json.data
	
	player_name = save_data.get("player_name", "")
	player_gender = save_data.get("player_gender", "male")
	
	var pos = save_data.get("player_position", {"x": 576, "y": 324})
	player_position = Vector2(pos.x, pos.y)
	
	play_time = save_data.get("play_time", 0.0)
	pokedex_caught = save_data.get("pokedex_caught", 0)
	
	print("Partida cargada exitosamente")
	return true

# Verificar si existe un guardado
func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

# Resetear datos
func reset_data():
	player_name = ""
	player_gender = "male"
	player_position = Vector2(576, 324)
	play_time = 0.0
	pokedex_caught = 0
