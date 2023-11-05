players = ds_list_create();
num_players = 0;

/// @desc Calls get_steam_deck_info from system scripts and stores results locally.
///       Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
function init_steam_deck_info() {
	steam_deck_info = get_steam_deck_info();
}

/// @desc Adds a new player to manager, returns player index.
function add_player() {
	var _new_player = new ControlManagerPlayer();
	ds_list_add(players, _new_player);
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