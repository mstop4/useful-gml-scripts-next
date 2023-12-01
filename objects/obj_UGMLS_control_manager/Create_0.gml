players = ds_list_create();
num_players = 0;
device_count = gamepad_get_device_count();
gamepad_connected = array_create(device_count, false);
num_gamepads_connected = 0;
gamepad_discovery_mode = false;
gamepad_discovery_player_index = 0;

/// @desc Checks the connection status of devices
check_device_connection_statuses = method(self, function() {
	gamepad_connected = array_create(device_count, false);
	num_gamepads_connected = 0;

	for (var _i=0; _i<device_count; _i++) {
		var _is_connected = gamepad_is_connected(_i);
		if (_is_connected) {
			num_gamepads_connected++;
		}
		gamepad_connected[_i] = _is_connected;
	}
});

/// @desc Starts listening for any input on any gamepad
start_gamepad_discovery_mode = method(self, function(_player_index) {
	gamepad_discovery_mode = true;
	gamepad_discovery_player_index = _player_index;
});

/// @desc Listens for any input on any gamepad. If detected, returns device index
listen_for_gamepad_input = method(self, function() {
	var _gamepad_index = -1;
	
	for (var _i=0; _i<device_count; _i++) {
		if (_gamepad_index != -1) break;

		for (var _j=gp_face1; _j<=gp_padr; _j++) {
			if (gamepad_button_check_pressed(_i, _j)) {
				_gamepad_index = _i;
				break;
			}
		}
	}
	
	if (_gamepad_index != -1) {
		self.stop_gamepad_discovery_mode();
		self.players[| self.gamepad_discovery_player_index].set_gamepad_slot(_gamepad_index);
	}
});

/// @desc Stop listening for input on any gamepad
stop_gamepad_discovery_mode = method(self, function() {
	gamepad_discovery_mode = false;
});

/// @desc Adds a new player to manager, returns player index.
add_player = method(self, function() {
	var _new_player = new ControlManagerPlayer(id);
	ds_list_add(self.players, _new_player);
	num_players++;
	return num_players-1;
});

/// @desc					Gets player with the given index.
/// @param {real} _index
get_player = method(self, function(_index) {
	if (ds_list_size(self.players) > _index) {
		return self.players[| _index];
	}
	
	return noone;
});

/// @desc Calls get_steam_deck_info from system scripts and stores results locally.
///       Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
init_steam_deck_info = method(self, function() {
	steam_deck_info = get_steam_deck_info();
});

/// @desc		 Checks if the game is currently running on a Steam Deck.
/// @returns {bool}
is_on_steam_deck = method(self, function() {
	return self.steam_deck_info.is_on_steam_deck;
});

/// @desc		 Gets the gamepad index of Steam Deck's built-in controls.
/// @returns {real}
get_steam_deck_gamepad_index = method(self, function() {
	return self.steam_deck_info.gamepad_index;
});