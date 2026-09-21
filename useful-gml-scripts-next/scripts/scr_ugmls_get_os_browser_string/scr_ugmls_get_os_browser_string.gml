/// @desc	 Converts os_browser enum value into a human-readable string.
/// @param {Constant.BrowserType} _os_browser
function get_os_browser_string(_os_browser) {
	if (_os_browser == browser_not_a_browser) {
		return "Not a browser";
	} 

	try {
		return global.ugmls_os_browser_strings[_os_browser];
	} catch (_e) {
		return global.ugmls_os_browser_strings[browser_unknown];
	}
}