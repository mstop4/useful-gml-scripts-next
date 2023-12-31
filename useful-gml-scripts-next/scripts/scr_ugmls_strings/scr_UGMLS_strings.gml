/// @desc  Formats a long string so that it doesn't exceed max_width by adding line breaks where appropriate.
/// @param {string}				_str        
/// @param {real}					_max_width 
/// @param {Asset.GMFont} _font       
function dialogue_line_breaker(_str, _max_width, _font) {
	var _old_font = draw_get_font();
	draw_set_font(_font);
    
	// check to see if the string is already short enough to fit on one line.
	if (string_width(_str) <= _max_width)
		return _str;
    
	var _out_str = "";
	var _in_str_len = string_length(_str);
	var _line_buffer = "";
	var _word_buffer = "";
	var _cur_char = "";
    
	// break up string into lines
	for (var _i=1; _i<=_in_str_len; _i++) {
	  _cur_char = string_char_at(_str,_i);
        
	  // manual line break
	  if (_cur_char == "\n") {
		  // if current line is too long, break it
		  if (string_width(_line_buffer + _word_buffer) > _max_width) {
		    _out_str += _line_buffer + "\n" + _word_buffer + "\n";
			} else {
		    _out_str += _line_buffer + _word_buffer + "\n";
			}
            
		  _line_buffer = "";
		  _word_buffer = "";
	  } else if (_cur_char == " ") { // space
			if (string_width(_line_buffer + _word_buffer + _cur_char) > _max_width) {
	      _out_str += _line_buffer + _word_buffer + "\n";
	      _line_buffer = "";
	      _word_buffer = "";
	    } else {
	      _line_buffer += _word_buffer + _cur_char;
	      _word_buffer = "";
	    }    
	  } else { // others
	    if (string_width(_line_buffer + _word_buffer + _cur_char) > _max_width) {
	      _out_str += _line_buffer + "\n";
	      _line_buffer = "";
	      _word_buffer += _cur_char;
	    } else {
	      _word_buffer += _cur_char;
	    }   
	  }
        
	  // end of line
	  if (_i == _in_str_len) {
	    _out_str += _line_buffer + _word_buffer;
	  }
	}

	draw_set_font(_old_font);

	return _out_str;
}

/// @desc	 Pads a string with char until it is a certain width (in pixels)
/// @param {string}				 _str
/// @param {string}				 _char
/// @param {Asset.GMFont}  _font
/// @param {real}					 _position
/// @param {real}					 _width
function pad_string_width(_str, _char, _font, _position, _width) {
	var _cur_font = draw_get_font();
	draw_set_font(_font);
	while (string_width(_str + _char) < _width) {
		_str = string_insert(_char, _str, _position);
	}

	draw_set_font(_cur_font);
	return _str;
}

/// @desc	 Truncates a long string and add a suffix at the end.
/// @param {string}				 _string
/// @param {string}				 _suffix
/// @param {Asset.GMFont}  _font
/// @param {real}					 _max_width
function hide_overflow(_string, _suffix, _font, _max_width) {
	var _cur_font = draw_get_font();
	var _cur_str = _suffix;
	var _prev_str = _suffix;
	var _str_len = string_length(_string);
	var _index = 1;
	
	while (string_width(_cur_str) <= _max_width && _index <= _str_len) {
		_prev_str = _cur_str;
		_cur_str = string_insert(string_char_at(_string, _index), _cur_str, _index);
		_index++;
	}
	
	draw_set_font(_cur_font);
	return _index <= _str_len ? _prev_str : _string;
}