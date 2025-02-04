/// @desc	 Compares all cells of two DS Grids for equality.
/// @param {Id.DsGrid} _grid1
/// @param {Id.DsGrid} _grid2
function grids_are_equal(_grid1, _grid2) {
	return ds_grid_write(_grid1) == ds_grid_write(_grid2);
}

/// @desc	 Chooses a random element from an array, but does not remove it.
/// @param {Array} _array
function choose_from_array(_array) {
	return _array[irandom(array_length(_array)-1)];
}

/// @desc	 Chooses a random element from an arrray and removes it from the array.
/// @param {Array} _array
function pick_out_from_array(_array) {
	var _index = irandom(array_length(_array)-1);
	var _choice = _array[_index];
	array_delete(_array, _index, 1);
	
	return {
		value: _choice,
		index: _index
	};
}

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

/// @desc  Creates an array containing numbers from _a to _b (inclusive by default), each _step units apart
/// @param {Real} _a
/// @param {Real} _b
/// @param {Real} _step
/// @param {Bool} [_include_b]
/// @param {Bool} [_shuffle]
function create_numeric_sequence_array(_a, _b, _step, _include_b = true, _shuffle = false) {
	var _arr = [];
	var _signed_step = abs(_step) * sign(_b - _a);
	for (var _i=_a; _i<_b; _i+=_signed_step) {
		array_push(_arr, _i);
	}
	
	if (_include_b) {
		array_push(_arr, _b);
	}
	
	return _shuffle ? array_shuffle(_arr) : _arr;
}

/// @desc	 Creates a new shallow copy of a given array.
/// @param {Array} _array
function duplicate_array(_array) {
	var _new_array = array_create(array_length(_array));
	array_copy(_new_array, 0, _array, 0, array_length(_array));
	return _new_array;
}

/// @desc Returns a deep clone of an array or struct
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

/// @desc	 Randomly shuffles the elements in a given array.
///        Deprecated: use array_shuffle instead
/// @deprecated
/// @param {Array} _array
function shuffle_array(_array) {
  var _current_index = array_length(_array);
	var _random_index;

  // While there remain elements to shuffle
  while (_current_index != 0) {
    // Pick a remaining element
    _random_index = irandom(_current_index - 1);
    _current_index--;

    // And swap it with the current element
		var _temp = _array[_current_index];
		_array[_current_index] = _array[_random_index];
		_array[_random_index] = _temp;
  }

  return _array;
}

/// @desc		 Parses a standard JSON from file.
/// @param   {String} _filename
function file_json_parse(_filename) {
  var _json_buffer = buffer_load(_filename);
  var _json = json_parse(buffer_read(_json_buffer, buffer_text));
  buffer_delete(_json_buffer);
  
  return _json;
}

/// @desc		 Parses a JSON with Comments from file, stripping out the comments.
/// @param   {String} _filename
function file_jsonc_parse(_filename) {
	var _jsonc_file = file_text_open_read(_filename);
	if (_jsonc_file == -1) return {};
	
	var _json_str = "";
	var _is_in_multiline_comment = false;
	
	while (!file_text_eof(_jsonc_file)) {
		var _line = file_text_readln(_jsonc_file);
		
		// Strip comments
		if (!_is_in_multiline_comment) {
			var _single_line_comment_pos = string_pos("\/\/", _line);
			var _multi_line_comment_start_pos = string_pos("\/*", _line);
			var _new_line = _line;
			
			if (_single_line_comment_pos != 0
				&& (_multi_line_comment_start_pos == 0 || _single_line_comment_pos < _multi_line_comment_start_pos)) {
				// Single-line comment
				_new_line = string_copy(_line, 1, _single_line_comment_pos-1);
			} else if (_multi_line_comment_start_pos != 0) {
				// Start of multi-line comment
				_new_line = string_copy(_line, 1, _multi_line_comment_start_pos-1);
				
				// Does it end on the same line?
				var _multi_line_comment_end_pos = string_pos("*\/", _line);
				if (_multi_line_comment_end_pos != 0 && _multi_line_comment_end_pos > _multi_line_comment_start_pos) {
					var _str_len = string_length(_line);
					var _length_left = _str_len - (_multi_line_comment_end_pos+1);
					_new_line += string_copy(_line, _multi_line_comment_end_pos+2, _length_left);
				} else {
					_is_in_multiline_comment = true;
				}
			}
				
			_json_str += _new_line;
		} else {
			var _multi_line_comment_end_pos = string_pos("*\/", _line);

			if (_multi_line_comment_end_pos != 0) {
				var _str_len = string_length(_line);
				var _length_left = _str_len - (_multi_line_comment_end_pos+1);
				var _new_line = string_copy(_line, _multi_line_comment_end_pos+2, _length_left);
				_is_in_multiline_comment = false;
				_json_str += _new_line;
			}
		}
	}
	
	file_text_close(_jsonc_file);
	
	return json_parse(_json_str);
}