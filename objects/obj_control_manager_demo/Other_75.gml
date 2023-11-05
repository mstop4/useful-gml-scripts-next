if (async_load[? "event_type"] == "gamepad discovered") {
	num_controllers_connected++;
	gamepad_connected[async_load[? "pad_index"]] = true;
} else if (async_load[? "event_type"] == "gamepad lost") {
	num_controllers_connected--;	
	gamepad_connected[async_load[? "pad_index"]] = false;
}