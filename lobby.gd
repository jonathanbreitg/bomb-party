extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ding_sound = preload("res://Ding - Sound Effect (HD)-GVAF07-2Xic.mp3")
var buzzer_sound = preload("res://buzzer.mp3")

onready var prompt = get_node("Control/Bomb/prompt")
var test_text = "טיפש"
export var websocket_url = "wss://websocket-bomb-party.jonathanbreitg.repl.co"
var wordslist = ["accuse",
"admit",
"claim",
"complaint",
"contact",
"court",
"creativity",
"database",
"delay",
"design",
"enthusiastic",
"hire",
"insist",
"member",
"official",
"origin",
"original",
"officially",
"photograph",
"private",
"program",
"rearrange",
"register",
"site",
"warning",
"break the rules",
"get off the ground",
"log on",
"on purpose",
"put off",
"reach an agreement",]
# Our WebSocketClient instance
var _client = WebSocketClient.new()
var index_to_check# = test_text[randi()%len(test_text)
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	print(test_text)
	print(invert_string(test_text))
	
	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	test_text = wordslist[randi()%(len(wordslist))]
	print(test_text)
	index_to_check = randi()%len(test_text)
	test_text = test_text.substr(index_to_check,3)
	prompt.text = test_text
func _closed(was_clean=false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.

	_client.get_peer(1).put_packet("get_lobby_info".to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())

func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	$Label2.text=str($"player-base/Timer".time_left)
static func invert_string(s:String)->String:
	var chars_pool = PoolStringArray()
	var length = s.length()
	chars_pool.resize(length)
	for i in length:
		chars_pool[i] = s[i]
	chars_pool.invert()
	return chars_pool.join("")


func _on_Timer_timeout():
	#change word
	$"player-base/player".stream = buzzer_sound
	$"player-base/player".play(0.2)
	test_text = wordslist[randi()%(len(wordslist))]
	print(test_text)
	index_to_check = randi()%len(test_text)
	test_text = test_text.substr(index_to_check,3)
	prompt.text = test_text
	
	

func _on_LineEdit_text_entered(new_text):
	#check if true
	if test_text in new_text && wordslist.has(new_text):
		print("ok")
		$"player-base/player".stream = ding_sound
		$"player-base/player".play()
		test_text = wordslist[randi()%(len(wordslist))]
		print(test_text)
		index_to_check = randi()%len(test_text)
		test_text = test_text.substr(index_to_check,3)
		prompt.text = test_text
		$"player-base/Timer".stop()
		$"player-base/Timer".start()
		$"player-base/LineEdit".text = ""
		
