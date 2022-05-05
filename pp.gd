extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("/root/Globlas").pp != null:
		self.texture = get_node("/root/Globlas").pp
	if get_node("/root/Globlas").playername != null:
		get_node("name").text = get_node("/root/Globlas").playername
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_player_finished():
	get_parent().get_node("player").stop()
