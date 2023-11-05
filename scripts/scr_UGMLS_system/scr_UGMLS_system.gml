global.ugmls_os_type_strings = [];
global.ugmls_os_type_strings[os_windows] = "Windows";
global.ugmls_os_type_strings[os_uwp] = "Universal Windows Platform";
global.ugmls_os_type_strings[os_operagx] = "Opera GX";
global.ugmls_os_type_strings[os_linux] = "Linux";
global.ugmls_os_type_strings[os_macosx] = "macOS";
global.ugmls_os_type_strings[os_ios] = "iOS";
global.ugmls_os_type_strings[os_tvos] = "Apple tvOS";
global.ugmls_os_type_strings[os_android] = "Android";
global.ugmls_os_type_strings[os_ps4] = "PlayStation 4";
global.ugmls_os_type_strings[os_ps5] = "PlayStation 5";
global.ugmls_os_type_strings[os_xboxone] = "Xbox One";
global.ugmls_os_type_strings[os_xboxseriesxs] = "Xbox Series X/S";
global.ugmls_os_type_strings[os_switch] = "Nintendo Switch";

global._ugmls_os_browser_strings = [];
global._ugmls_os_browser_strings[browser_unknown] = "Unknown Browser";
global._ugmls_os_browser_strings[browser_ie] = "Internet Explorer";
global._ugmls_os_browser_strings[browser_ie_mobile] = "Mobile Internet Explorer";
global._ugmls_os_browser_strings[browser_firefox] = "Firefox";
global._ugmls_os_browser_strings[browser_chrome] = "Chrome";
global._ugmls_os_browser_strings[browser_safari] = "Safari";
global._ugmls_os_browser_strings[browser_safari_mobile] = "Mobile Safari";
global._ugmls_os_browser_strings[browser_opera] = "Opera";
global._ugmls_os_browser_strings[browser_tizen] = "Tizen";
global._ugmls_os_browser_strings[browser_windows_store] = "Windows App";

/// @desc					Converts os_type enum value into a human-readable string.
/// @param {real} _os_type
function get_os_type_string(_os_type){
	try {
		return global.ugmls_os_type_strings[_os_type];
	} catch (_e) {
		return "Unknown OS";
	}
}

/// @desc					Converts os_version into a human-readable string.
/// @param {real} _os_version
function get_os_version_string(_os_version) {
	// Browser
	if (os_browser != browser_not_a_browser || os_type == os_operagx) {
		return "N/A";
	}
	
	// Windows
	if (os_type == os_windows) {
		var _major_v = _os_version >> 16;
		var _minor_v = _os_version & 65535;
		return string(_major_v) + "." + string(_minor_v);
	}
	
	// macOS and iOS
	if (os_type == os_macosx || os_type == os_ios) {
		var _major_v = _os_version >> 24;
		var _minor_v = (_os_version >> 12) & 4095;
		var _build = _os_version & 4095;
		return string(_major_v) + "." + string(_minor_v) + "." + string(_build);
	}
	
	// All other cases (including unknown platform)
	return string(_os_version);
}

/// @desc													Converts os_browser enum value into a human-readable string.
/// @param {Constant.BrowserType} _os_browser
function get_os_browser_string(_os_browser) {
	if (_os_browser == browser_not_a_browser) {
		return "Not a browser";
	} 

	try {
		return global._ugmls_os_browser_strings[_os_browser];
	} catch (_e) {
		return global._ugmls_os_browser_strings[browser_unknown];
	}
}

/// @desc							Checks if game is running on Steam Deck and which gamepad slot the controls are connected to.
///										Note: Doesn't work if called at the very start of the game. Wait a few steps before calling it.
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