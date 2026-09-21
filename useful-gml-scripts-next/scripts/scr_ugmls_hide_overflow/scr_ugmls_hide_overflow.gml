/// @desc	 Truncates a long string and add a suffix at the end.
/// @param {string}				 _string
/// @param {string}				 _suffix
/// @param {Asset.GMFont}  _font
/// @param {real}					 _max_width
function hide_overflow(_string, _suffix, _font, _max_width) {
	var _cur_font = draw_get_font();
	var _cur_str = _suffix;
	var _prev_str = _suffix;
	var _str_len = string_length(_string);
	var _index = 1;
	
	while (string_width(_cur_str) <= _max_width && _index <= _str_len) {
		_prev_str = _cur_str;
		_cur_str = string_insert(string_char_at(_string, _index), _cur_str, _index);
		_index++;
	}
	
	draw_set_font(_cur_font);
	return _index <= _str_len ? _prev_str : _string;
}