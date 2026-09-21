/// @desc  Shifts the components of an HSV colour
/// @param {real} _base_color  
/// @param {real} _variance_hue 
/// @param {real} _variance_sat 
/// @param {real} _variance_val 
function vary_colour_hsv(_base_color, _variance_hue, _variance_sat, _variance_val) {
	var _temp_hue = (color_get_hue(_base_color) + _variance_hue + 256) mod 256;
	var _temp_sat = (color_get_saturation(_base_color) + _variance_sat + 256) mod 256;
	var _temp_val = (color_get_value(_base_color) + _variance_val + 256) mod 256;

	return make_color_hsv(_temp_hue, _temp_sat, _temp_val);
}