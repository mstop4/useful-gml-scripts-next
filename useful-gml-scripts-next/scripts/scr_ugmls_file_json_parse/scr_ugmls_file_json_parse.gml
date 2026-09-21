/// @desc		 Parses a standard JSON from file.
/// @param   {String} _filename
function file_json_parse(_filename) {
  var _json_buffer = buffer_load(_filename);
  var _json = json_parse(buffer_read(_json_buffer, buffer_text));
  buffer_delete(_json_buffer);
  
  return _json;
}