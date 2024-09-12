extends Node

func _ready() -> void:
	DiscordRPC.app_id = 985579917406265354 # Application ID
	DiscordRPC.details = "3DSpiel"
	DiscordRPC.state = "Some State"
	# DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
	# DiscordRPC.large_image_text = "Try it now!"
	# DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	# DiscordRPC.small_image_text = "Fighting the end boss! D:"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())

	DiscordRPC.refresh() # Always refresh after changing the values!
