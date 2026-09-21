/// @desc	 Checks if Arrays a and b have any common elements
/// @param {Array} _a
/// @param {Array} _b
function arrays_overlap(_a, _b) {
  var _a_len = array_length(_a);
	var _b_len = array_length(_b);
	
	for (var _i=0; _i<_a_len; _i++) {
		for (var _j=0; _j<_b_len; _j++) {
			if (_a[_i] == _b[_j]) return true;
		}
  }
	
	return false;
}