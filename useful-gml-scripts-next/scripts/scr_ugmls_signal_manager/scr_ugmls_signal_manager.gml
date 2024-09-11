function Signal(_listener, _once) constructor {
	listener = _listener;
	once = _once;
}

function SignalManager() constructor {
	signals = {};

	/// @desc  Adds a listener to a signal
	/// @param {string} _name
	/// @param {function} _listener
	/// @param {bool} _once
	/// @param {Struct, Id.Instance, undefined} _context
	/// @returns {real}
	function add(_name, _listener, _once = false, _context = undefined) {
		if (!is_callable(_listener)) {
			show_debug_message("ERROR: SignalManager.add - _listener is not a function or method");
			return -1;
		}
		
		if (!struct_exists(signals, _name)) {
			signals[$ _name] = [];
		}
	
		var _listener_method = _context != undefined
			? method(_context, _listener)
			: _listener;
		
		var _signal = new Signal(_listener_method, _once);
		array_push(signals[$ _name], _signal);
	
		return array_length(signals[$ _name]);
	}

	/// @desc  Dispatches a signal
	/// @param {string} _name
	/// @returns {bool}
	function dispatch(_name) {
		if (!struct_exists(signals, _name)) {
			show_debug_message($"ERROR: SignalManager.dispatch - no signal with name {_name} found");
			return false;
		}
		
		var _num_listeners = array_length(signals[$ _name]);
	
		for (var _i=0; _i<_num_listeners; _i++) {	
			signals[$ _name][_i].listener();
		
			if (signals[$ _name][_i].once) {
				remove(_name, _i);
				_num_listeners--;
				_i--;
			}
		}
		
		return true;
	}

	/// @desc  Removes listener(s) from a signal.
	///        _index = -1 - remove all listners
	///        _index = >= 0 - remove listener at given index if it exists
	/// @param {string} _name
	/// @param {real} _index
	function remove(_name, _index = -1) {
		if (!struct_exists(signals, _name)) {
			show_debug_message($"ERROR: SignalManager.remove - no signal with name {_name} found");
			return false;
		}		
		
		if (_index == -1) {
			signals[$ _name] = [];
		} else {
			if (_index >= array_length(signals[$ _name])) {
				show_debug_message($"ERROR: SignalManager.dispatch - index {_index} out of range for signal {_name}");
				return false;
			}			
			
			array_delete(signals[$ _name], _index, 1);
		}
	}
}