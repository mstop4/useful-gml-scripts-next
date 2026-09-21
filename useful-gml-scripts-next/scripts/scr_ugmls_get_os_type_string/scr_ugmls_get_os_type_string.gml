/// @desc	 Converts os_type enum value into a human-readable string.
/// @param {real} _os_type
function get_os_type_string(_os_type){
	try {
		return global.ugmls_os_type_strings[_os_type];
	} catch (_e) {
		return "Unknown OS";
	}
}