// Feather ignore GM2016

if (!control_manager.gamepad_discovery_mode) {
	control_manager.start_gamepad_discovery_mode(0, function(_index, _msg) {
		show_debug_message($"Game Discovery Callback: Gamepad {_index} detected! Message: {_msg}");
	}, ["foo"]);
} else {
	control_manager.stop_gamepad_discovery_mode();
}

// Feather restore GM2016