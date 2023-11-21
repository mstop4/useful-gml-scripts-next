players = ds_list_create();
num_players = 0;
device_count = gamepad_get_device_count();
gamepad_connected = array_create(device_count, false);
num_gamepads_connected = 0;

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

/// @desc Adds a new player to manager, returns player index.
function add_player() {
	var _new_player = new ControlManagerPlayer();
	ds_list_add(self.players, _new_player);
	num_players++;
	return num_players-1;
}

/// @desc								Gets player with the given index.
/// @param {real} _index
function get_player(_index) {
	if (ds_list_size(self.players) > _index) {
		return self.players[| _index];
	}
	
	return noone;
}

/// @desc Calls get_steam_deck_info from system scripts and stores results locally.
///       Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
function init_steam_deck_info() {
	steam_deck_info = get_steam_deck_info();
}

/// @desc					  Checks if the game is currently running on a Steam Deck.
/// @returns {bool}
function is_on_steam_deck() {
	return self.steam_deck_info.is_on_steam_deck;
}

/// @desc					  Gets the gamepad index of Steam Deck's built-in controls.
/// @returns {real}
function get_steam_deck_gamepad_index() {
	return self.steam_deck_info.gamepad_index;
}