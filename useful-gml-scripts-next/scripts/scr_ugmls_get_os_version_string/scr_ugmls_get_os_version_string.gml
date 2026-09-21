/// @desc	 Converts os_version into a human-readable string.
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