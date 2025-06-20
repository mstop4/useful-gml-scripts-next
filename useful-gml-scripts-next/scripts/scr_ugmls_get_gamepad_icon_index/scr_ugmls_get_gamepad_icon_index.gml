/// @desc	 Converts keycode to image_index of keyboard icon
/// @param {real}						_button_code
/// @param {Asset.GMSprite} _icons
function get_gamepad_icon_index(_button_code, _icons) {
	var _offset_code = _button_code - 32768;
	if (_offset_code < 0) return sprite_get_number(_icons) - 1;
	return global.ugmls_gamepad_icon_map[_offset_code] == -1
		? sprite_get_number(_icons) - 1
		: global.ugmls_gamepad_icon_map[_offset_code];
}