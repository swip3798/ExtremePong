extends Node

const BROADCAST_COMMAND = "arp"
var broadcast_ip

func _ready():
	print(BROADCAST_COMMAND)
	_get_broadcast_ip()

func _get_broadcast_ip():
	var ips = []
	var regex = RegEx.new()
	regex.compile(".*?([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}).*?ff\\-ff\\-ff\\-ff\\-ff\\-ff")
	var output = []
	OS.execute(BROADCAST_COMMAND, ["-a"], true, output)
	for line in output:
		ips.append(regex.search(line).get_string())
	print(ips)
	
	
