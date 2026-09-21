/// @desc	 Checks if Array a is a subset of array b.
/// @param {Array} _a
/// @param {Array} _b
function array_is_subset(_a, _b) {
	var _a_len = array_length(_a);
	var _b_len = array_length(_b);
	if (_a_len > _b_len) return false;

	var _match = false;
	
	for (var _i=0; _i<_a_len; _i++) {
		_match = false;
		for (var _j=0; _j<_b_len; _j++) {
			if (_a[_i] == _b[_j]) {
				_match = true;
				break;
			}
		}
		
		if (!_match) return false;
	}
	
	return true;
}