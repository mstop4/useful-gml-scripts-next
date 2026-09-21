/// @desc	 Pads a string with char until it is a certain width (in pixels)
/// @param {string}				 _str
/// @param {string}				 _char
/// @param {Asset.GMFont}  _font
/// @param {real}					 _position
/// @param {real}					 _width
function pad_string_width(_str, _char, _font, _position, _width) {
	var _cur_font = draw_get_font();
	draw_set_font(_font);
	while (string_width(_str + _char) < _width) {
		_str = string_insert(_char, _str, _position);
	}

	draw_set_font(_cur_font);
	return _str;
}