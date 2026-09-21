/// @desc Returns a deep clone of an array or struct
/// @deprecated Use built-in function variable_clone instead 
/// @param {Array,Struct} _obj
/// @returns {Any}
function deep_clone(_obj) {
	if (is_array(_obj)) {
		// Array
		var _copy_obj = array_create(array_length(_obj));
		
		for (var _i=0; _i<array_length(_obj); _i++) {
			_copy_obj[_i] = deep_clone(_obj[_i]);
		}
		
		return _copy_obj;
	} else if (is_struct(_obj)) {
		if (is_method(_obj)) {
			// Method
			return _obj;
		}

		// Struct
		var _copy_obj = {};
		var _obj_keys = struct_get_names(_obj);
		
		for (var _i=0; _i<array_length(_obj_keys); _i++) {
			var _val = _obj[$ _obj_keys[_i]];
			_copy_obj[$ _obj_keys[_i]] = deep_clone(_val);
		}

		return _copy_obj;
	} else {
		// Value
		return _obj;
	}
}