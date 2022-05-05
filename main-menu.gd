extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var pp
# Called when the node enters the scene tree for the first time.
func _ready():
	pp = get_node("player-base/pp")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	var picked_image:Image = yield(HTML5File.load_image(),"completed")
	print("done")
	print("picked image is",picked_image)
	if picked_image == null:
		var new_image = Image.new()
		print("got here 1")
		new_image.texture = load("user://pp.png")
		print('got here 2')
		print(new_image)
		if !new_image:
			pp.Texture = new_image
			print("got here 3")
		print("got here 4")
	var tex = ImageTexture.new()
	tex.create_from_image(picked_image, 0) # Flag = 0 or else export is fucked!
	tex = get_resized_texture(tex,128,128)
	pp.texture = tex
	get_node("/root/Globlas").pp = tex
	
func get_resized_texture(t: Texture, width: int = 0, height: int = 0):
	var image = t.get_data()
	if width > 0 && height > 0:
		image.resize(width, height)
	var itex = ImageTexture.new()
	itex.create_from_image(image)
	return itex



func _on_Button_pressed():
	print("joining lobby...")
	get_tree().change_scene("res://lobby.tscn")


func _on_LineEdit_text_changed(new_text):
	get_node("/root/Globlas").playername = new_text
	get_node("player-base/pp/name").text = new_text
