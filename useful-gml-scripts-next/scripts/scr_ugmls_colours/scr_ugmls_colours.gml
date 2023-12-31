/// @desc  Returns interpolated colour between two HSV colours.
/// @param {real} _base_color1 colour
/// @param {real} _base_color2 colour
/// @param {real} _t
function interpolate_hsv(_base_color1, _base_color2, _t) {
	var _temp_hue = lerp(color_get_hue(_base_color1), color_get_hue(_base_color2), _t);
	var _temp_sat = lerp(color_get_saturation(_base_color1), color_get_saturation(_base_color2), _t);
	var _temp_val = lerp(color_get_value(_base_color1), color_get_value(_base_color2), _t);

	return make_color_hsv(_temp_hue, _temp_sat, _temp_val);
}

/// @desc    Converts RGB int/hex to BGR real (Deprecated: use RGB hexcodes (e.g. #RRGGBB) or rgb_hex_string_to_real instead)
/// @deprecated
/// @param   {real} _rgb_colour colour
/// @returns {real}
function rgb_to_bgr(_rgb_colour) {
	return (_rgb_colour & $FF) << 16 | (_rgb_colour & $FF00) | (_rgb_colour & $FF0000) >> 16;
}

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

/// @desc  Shifts the components of an HSV colour
/// @param {real} _base_color  
/// @param {real} _variance_hue 
/// @param {real} _variance_sat 
/// @param {real} _variance_val 
function vary_color_hsv(_base_color, _variance_hue, _variance_sat, _variance_val) {
	var _temp_hue = (color_get_hue(_base_color) + _variance_hue + 256) mod 256;
	var _temp_sat = (color_get_saturation(_base_color) + _variance_sat + 256) mod 256;
	var _temp_val = (color_get_value(_base_color) + _variance_val + 256) mod 256;

	return make_color_hsv(_temp_hue, _temp_sat, _temp_val);
}