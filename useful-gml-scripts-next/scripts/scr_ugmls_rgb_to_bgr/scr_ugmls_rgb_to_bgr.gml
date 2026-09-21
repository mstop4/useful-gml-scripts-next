/// @desc    Converts RGB int/hex to BGR real
/// @deprecated use RGB hexcodes (e.g. #RRGGBB) or rgb_hex_string_to_real instead
/// @param   {real} _rgb_colour colour
/// @returns {real}
function rgb_to_bgr(_rgb_colour) {
	return (_rgb_colour & $FF) << 16 | (_rgb_colour & $FF00) | (_rgb_colour & $FF0000) >> 16;
}