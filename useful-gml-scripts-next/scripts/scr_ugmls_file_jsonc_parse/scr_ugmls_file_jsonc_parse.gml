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