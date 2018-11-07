extends Node2D

var IP_CLIENT
var PORT_CLIENT
var PORT_SERVER = 6969
var socketUDP = PacketPeerUDP.new()

signal got_message

func _ready():
	set_process(false)

func _process(delta):   
	if socketUDP.get_available_packet_count() > 0:
		var array_bytes = socketUDP.get_packet()
		var IP_CLIENT = socketUDP.get_packet_ip()
		var msg_from_server = array_bytes.get_string_from_utf8()
		print("msg server: " + msg_from_server)
		print("msg ip: " + IP_CLIENT) 
		if msg_from_server.find("ExtremePong GameSession:") != -1:
			emit_signal("got_message", msg_from_server, IP_CLIENT)
		

func start_server():
	if (socketUDP.listen(PORT_SERVER) != OK):
		printt("Error listening on port: " + str(PORT_SERVER))
	else:
		set_process(true)
		printt("Listening on port: " + str(PORT_SERVER))

func _exit_tree():
	socketUDP.close()
