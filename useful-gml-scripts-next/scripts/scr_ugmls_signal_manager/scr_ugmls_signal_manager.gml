function Signal(_listener, _once) constructor {
	listener = _listener;
	once = _once;
}

function SignalManager() constructor {
	signals = {};

	/// @desc
	/// @param {string} _name
	/// @param {function} _listener
	/// @param {bool} _once
	/// @param {Struct, Id.Instance, undefined} _context
	function add(_name, _listener, _once = false, _context = undefined) {
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

	/// @desc
	/// @param {string} _name
	function dispatch(_name) {
		var _num_listeners = array_length(signals[$ _name]);
	
		for (var _i=0; _i<_num_listeners; _i++) {	
			signals[$ _name][_i].listener();
		
			if (signals[$ _name][_i].once) {
				remove(_name, _i);
				_num_listeners--;
				_i--;
			}
		}
	}

	/// @desc
	/// @param {string} _name
	/// @param {real} _index
	function remove(_name, _index = -1) {
		if (_index == -1) {
			signals[$ _name] = [];
		} else {
			array_delete(signals[$ _name], _index, 1);
		}
	}
}