/// @desc		 Checks if game is running on Steam Deck and which gamepad slot the controls are connected to.
///					 Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
/// @returns {Struct}
function get_steam_deck_info() {
	var _result = {
		is_on_steam_deck: false,
		gamepad_index: 0,
	}
	
	// Check all gamepad slots for "Steam Virtual Gamepad"
	var _num_devices = gamepad_get_device_count();
  for (var _i = 0; _i < _num_devices; _i++;) {
    if (gamepad_is_connected(_i)) {
      var _description = gamepad_get_description(_i);
      if (string_pos("Steam Virtual Gamepad", _description) != 0) {
        _result.gamepad_index = _i;
      }
    }
  }
	
	// Check Device Info to see if it matches Steam Deck hardware
	var _os_info = os_get_info();
	
	// No info found, return early
	if (_os_info == -1) return _result;
  var _vendor = _os_info[? "gl_vendor_string"];
  var _version = _os_info[? "gl_version_string"];	
  var _renderer = _os_info[? "gl_renderer_string"];
	
  // Vendor should be "AMD"
  // Version should contain "Mesa"
	// Renderer should be "AMD Custom GPU 0405"
  if (string_pos("AMD", _vendor) != 0
		&& string_pos("Mesa", _version) != 0
    && string_pos("AMD Custom GPU 0405", _renderer) != 0) {
    _result.is_on_steam_deck = true;
  }
	
	ds_map_destroy(_os_info);
	return _result;
}