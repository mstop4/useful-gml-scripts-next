/// @desc	 Converts keycode to image_index of keyboard icon
/// @param {real}						_keycode
/// @param {Asset.GMSprite} _icons
function get_keyboard_icon_index(_keycode, _icons) {
	if (_keycode < 0) return sprite_get_number(_icons) - 1;
	var _js_keycode = translate_native_to_js_keycode(_keycode);
	return global.ugmls_keyboard_icon_map[_js_keycode] == -1
		? sprite_get_number(_icons) - 1
		: global.ugmls_keyboard_icon_map[_js_keycode];
}