/// @desc    Converts RGB hex string to a real
/// @param   {string} _hex_str
/// @returns {real}
function rgb_hex_string_to_real(_hex_str) {
	if (!is_string(_hex_str)) return -1;
	var _str_len = string_length(_hex_str);
	var _value = 0;
	
	for (var _i=_str_len; _i>0; _i--) {
		_value = _value << 4;
		var _char = string_upper(string_copy(_hex_str, _i, 1));
		
		if (_char == "#") continue;
		var _ord = ord(_char);
		
		if (_ord >= ord("A") && _ord <= ord("F")) {
			_value += _ord - ord("A") + 10;
		} else if (_ord >= ord("0") && _ord <= ord("9")) {
			_value += real(_char);
		}
	}
	
	return _value;
}