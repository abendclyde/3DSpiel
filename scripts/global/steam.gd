extends Node

var username: String
var friends: Array

func _ready() -> void:
	initialize_steam()

func _process(delta: float) -> void:
	Steam.run_callbacks()

func initialize_steam() -> void:
	var initialize_response: Dictionary = Steam.steamInitEx()
	print("Steam initialized: %s" % initialize_response)

	username = Steam.getPersonaName()
	print("Steam user: %s" % username)
	friends = Steam.getUserSteamFriends()
	print("Steam friends: ", friends)
