extends Node2D

@export var levels: Array[PackedScene]

var _current_level: int = 1
var _level_instantiate: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_level(_current_level)
	


func _create_level(level_number: int):
	_level_instantiate = levels[level_number - 1].instantiate()
	add_child(_level_instantiate)
	var children := _level_instantiate.get_children()
	
	#var characters := get_tree().get_nodes_in_group("characters")
	#characters[0].dead_character.connect(_reset_level)
	
	for i in children.size():
		if children[i].is_in_group("characters"):
			children[i].dead_character.connect(_restart_level)
			break

func _delete_level():
	_level_instantiate.queue_free()
	
func _restart_level():
	_delete_level()
	_create_level(_current_level)

	
