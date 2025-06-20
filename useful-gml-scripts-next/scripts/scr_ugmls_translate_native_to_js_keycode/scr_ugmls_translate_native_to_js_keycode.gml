/// @desc	 Maps native keycodes to JS keycodes.
/// @param {real} _keycode
function translate_native_to_js_keycode(_keycode) {
	switch (os_type) {
		case os_macosx:
			if (_keycode == 222) return vk_single_quote;
			else if (_keycode == 50) return vk_backtick;
			else return _keycode;
			
		case os_linux:
			if (_keycode == 192) return vk_single_quote;
			else if (_keycode == 223) return vk_backtick;
			else return _keycode;
			
		default:
			// Windows, Web, etc.
			return _keycode;
	}
}