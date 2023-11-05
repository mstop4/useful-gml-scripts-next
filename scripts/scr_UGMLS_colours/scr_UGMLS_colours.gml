/// @desc         Returns interpolated colour between two HSV colours.
/// @param {real} _base_color1 colour
/// @param {real} _base_color2 colour
/// @param {real} _t
function interpolate_hsv(_base_color1, _base_color2, _t) {
	var _temp_hue = lerp(color_get_hue(_base_color1), color_get_hue(_base_color2), _t);
	var _temp_sat = lerp(color_get_saturation(_base_color1), color_get_saturation(_base_color2), _t);
	var _temp_val = lerp(color_get_value(_base_color1), color_get_value(_base_color2), _t);

	return make_color_hsv(_temp_hue, _temp_sat, _temp_val);
}