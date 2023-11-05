/// @desc      Syntactic sugar for show_debug_message.
/// @param {any} _value1
/// @param {any} [_value2]
/// @param {any} [_value3]
/// ...
function print(_value1, _value2, _value3) {
	var _str = "";

	for (var _i=0; _i<argument_count; _i++) {
		_str += $"argument[_i]";
	}

	show_debug_message(_str);
}