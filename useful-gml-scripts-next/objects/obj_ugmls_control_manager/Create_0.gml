players = [];
num_players = 0;
device_count = gamepad_get_device_count();
gamepad_connected = array_create(device_count, false);
num_gamepads_connected = 0;
gamepad_discovery_mode = false;
gamepad_discovery_player_index = 0;
gamepad_on_discovered_func = pointer_null;
gamepad_on_discovered_params = [];

/// @desc Checks the connection status of devices
function check_device_connection_statuses() {
	gamepad_connected = array_create(device_count, false);
	num_gamepads_connected = 0;

	for (var _i=0; _i<device_count; _i++) {
		var _is_connected = gamepad_is_connected(_i);
		if (_is_connected) {
			num_gamepads_connected++;
		}
		gamepad_connected[_i] = _is_connected;
	}
}

/// @desc Starts listening for any input on any 
/// @param {Real}			_player_index
/// @param {Function} _on_discovered_func
/// @param {Array}		_on_discovered_params
function start_gamepad_discovery_mode(_player_index, _on_discovered_func, _on_discovered_params) {
	gamepad_discovery_mode = true;
	gamepad_discovery_player_index = _player_index;
	gamepad_on_discovered_func = _on_discovered_func;
	gamepad_on_discovered_params = _on_discovered_params;
}

/// @desc Listens for any input on any gamepad. If detected, returns device index
function listen_for_gamepad_input() {
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
		if (is_callable(gamepad_on_discovered_func)) {
			gamepad_on_discovered_func(_gamepad_index, gamepad_on_discovered_params);
			gamepad_on_discovered_func = pointer_null;
		}
		self.players[self.gamepad_discovery_player_index].set_gamepad_slot(_gamepad_index);
		self.stop_gamepad_discovery_mode();
	}
};

/// @desc Stop listening for input on any gamepad
function stop_gamepad_discovery_mode() {
	gamepad_discovery_mode = false;
	gamepad_on_discovered_func = pointer_null;
};

/// @desc Adds a new player to manager, returns player index.
function add_player() {
	var _new_player = new ControlManagerPlayer(id);
	array_push(self.players, _new_player);
	num_players++;
	return num_players-1;
};

/// @desc					Gets player with the given index.
/// @param {real} _index
function get_player(_index) {
	if (array_length(self.players) > _index) {
		return self.players[_index];
	}
	
	return noone;
}

/// @desc Calls get_steam_deck_info from system scripts and stores results locally.
///       Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
function init_steam_deck_info() {
	global.ugmls_steam_deck_info = get_steam_deck_info();
}

/// @desc		 Checks if the game is currently running on a Steam Deck.
/// @returns {bool}
function is_on_steam_deck() {
	return global.ugmls_steam_deck_info.is_on_steam_deck;
}

/// @desc		 Gets the gamepad index of Steam Deck's built-in controls.
/// @returns {real}
function get_steam_deck_gamepad_index() {
	return global.ugmls_steam_deck_info.gamepad_index;
}