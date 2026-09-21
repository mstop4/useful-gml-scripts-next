/// @desc	 Finds a given value in an array and returns its index, if the value doesn't exists, returns -1.
///				 Note: array_find_index is more powerful and is recommended instead, but this function can still be used in some specialized cases.
/// @param {Array} _array
/// @param {any}	 _value
function array_find(_array, _value) {
	var _len = array_length(_array);
	for (var _i=0; _i<_len; _i++) {
		if (_array[_i] == _value) return _i;
	}
	
	return -1;
}