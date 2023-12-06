enum MENU_CONTROLS {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	CONFIRM,
	CANCEL,
	DELETE_BINDING,
	MAX
}

enum MENU_DISCOVERY_MODE {
	NONE,
	SELECTING,
	DISCOVERING
}

function MenuControlState(_player_inst) constructor {
	pressed_state = [];
	held_state = [];
	player_inst = _player_inst;
	
	for (var _i=0; _i< MENU_CONTROLS.MAX; _i++) {
		pressed_state[_i] = false;
		held_state[_i] = false;
	}
	
	poll_input = method(self, function() {
		pressed_state[MENU_CONTROLS.UP] = player_inst.get_control_state(CONTROLS.UP, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.DOWN] = player_inst.get_control_state(CONTROLS.DOWN, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.LEFT] = player_inst.get_control_state(CONTROLS.LEFT, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.RIGHT] = player_inst.get_control_state(CONTROLS.RIGHT, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.CONFIRM] = player_inst.get_control_state(CONTROLS.MENU_CONFIRM, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.CANCEL] = player_inst.get_control_state(CONTROLS.MENU_CANCEL, CONTROL_STATE.PRESSED);
		pressed_state[MENU_CONTROLS.DELETE_BINDING] = player_inst.get_control_state(CONTROLS.DELETE_BINDING, CONTROL_STATE.PRESSED);
	
		held_state[MENU_CONTROLS.UP] = player_inst.get_control_state(CONTROLS.UP, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.DOWN] = player_inst.get_control_state(CONTROLS.DOWN, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.LEFT] = player_inst.get_control_state(CONTROLS.LEFT, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.RIGHT] = player_inst.get_control_state(CONTROLS.RIGHT, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.CONFIRM] = player_inst.get_control_state(CONTROLS.MENU_CONFIRM, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.CANCEL] = player_inst.get_control_state(CONTROLS.MENU_CANCEL, CONTROL_STATE.HELD);
		held_state[MENU_CONTROLS.DELETE_BINDING] = player_inst.get_control_state(CONTROLS.DELETE_BINDING, CONTROL_STATE.HELD);
	});
	
	control_any_pressed = method(self, function() {
		return player_inst.ctrl_any_pressed;
	});
}

/// @func  MenuItem(config)
/// @param _config 
//         - {string} label
function MenuItem(_config) constructor {
	type = "item";
	label = _config.label;
	parent_menu = noone;
	enabled = true;
	
	set_enabled = method(self, function(_enabled) {
		enabled = _enabled;
	});
	
	destroy = method(self, function() {});
}

/// @func  MenuDivider(config)
/// @param _config 
//         - {string} label
function MenuDivider(_config) : MenuItem(_config) constructor {
	type = "divider";
}

/// @func  MenuSelectable(config)
/// @param _config 
//         - {string}   label
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {boolean}  silent_on_confirm
function MenuSelectable(_config) : MenuItem(_config) constructor {
	type = "selectable";
	on_confirm_func = _config.on_confirm_func;
	on_confirm_args = _config.on_confirm_args;
	silent_on_confirm = _config.silent_on_confirm;
}

/// @func  MenuValuedSelectable(config)
/// @param _config 
//         - {string}   label
//         - {string}   init_value
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change   NOTE: doesn't work yet
function MenuValuedSelectable(_config) : MenuSpinnerBase(_config) constructor {
	type = "valuedSelectable";
	value = _config.init_value;
	
	get_full_label = method(self, function() {
		return $"{label}: {value}";
	});
	
	get_value = method(self, function() {
		return value;
	});
	
	set_value = method(self, function(_value) {
		value = _value;
		if (is_callable(on_change_func)) {
			on_change_func(value, on_change_args);
		}

		// FIXME
		/*if (!silent_on_change && audio_exists(cursor_confirm_sfx)) {
			audio_play_sound(cursor_confirm_sfx, 1, false);
		}*/
	});
}

/// @func  MenuSpinnerBase(config)
/// @param _config 
//         - {string}   label
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
function MenuSpinnerBase(_config) : MenuItem(_config) constructor {
	type = "spinner";
	on_confirm_func = _config.on_confirm_func;
	on_confirm_args = _config.on_confirm_args;
	silent_on_confirm = _config.silent_on_confirm;
	on_change_func = _config.on_change_func;
	on_change_args = _config.on_change_args;
	silent_on_change = _config.silent_on_change;
}

/// @func  MenuSpinner(config)
/// @param _config 
//         - {string}   label
//         - {array}    values
//         - {integer}  init_index
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
function MenuSpinner(_config) : MenuSpinnerBase(_config) constructor {
	values = _config.values;
	cur_index = clamp(_config.init_index, 0, array_length(values) - 1);
	
	get_full_label = method(self, function() {
		return return $"{label}: {values[cur_index]}";
	});
	
	get_value = method(self, function() {
		return values[cur_index];
	});
}

/// @func  MenuKeyConfig(config)
/// @param _config 
//         - {string}   label
//         - {array}    initial_kbm_bindings
//         - {array}    initial_gamepad_bindings
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
/// @returns {Any}
function MenuKeyConfig(_config) : MenuItem(_config) constructor {
	type = "keyconfig";
	on_change_func = _config.on_change_func;
	on_change_args = _config.on_change_args;
	silent_on_confirm = _config.silent_on_confirm;
	silent_on_change = _config.silent_on_change;
	control = _config.control;
	kbm_bindings = _config.initial_kbm_bindings;
	gamepad_bindings = _config.initial_gamepad_bindings;
	current_binding_index = 0;
	locked_kbm_bindings = array_create(array_length(_config.initial_kbm_bindings), false);
	locked_gamepad_bindings = array_create(array_length(_config.initial_gamepad_bindings), false);
	discovery_binding_info = false;
	
	get_binding_info = method(self, function() {
		if (current_binding_index < 0) return false;
		if (current_binding_index >= GAMEPAD_MAX_BINDINGS_PER_CONTROL + KEYBOARD_MAX_BINDINGS_PER_CONTROL) return false;
		
		if (current_binding_index < KEYBOARD_MAX_BINDINGS_PER_CONTROL) {
			return {
				control_type: CONTROL_TYPE.KEYBOARD_AND_MOUSE,
				control_index: current_binding_index,
				binding_locked: locked_kbm_bindings[current_binding_index]
			}
		} else {
			var _true_index = current_binding_index - KEYBOARD_MAX_BINDINGS_PER_CONTROL;
			return {
				control_type: CONTROL_TYPE.GAMEPAD,
				control_index: _true_index,
				binding_locked: locked_gamepad_bindings[_true_index]
			}
		}
	});
	
	get_text_value = method(self, function(_control_type, _index) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			if (_index >= array_length(kbm_bindings)) {
				return "-";
			} else if (discovery_binding_info
				&& discovery_binding_info.control_type == _control_type
				&& discovery_binding_info.control_index == _index) {
				return "_";
			} else {
				return keycode_to_string(kbm_bindings[_index]);
			}
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			if (_index >= array_length(gamepad_bindings)) {
				return "-";
			} else if (discovery_binding_info
				&& discovery_binding_info.control_type == _control_type
				&& discovery_binding_info.control_index == _index) {
				return "_";
			} else {
				return gamepad_constant_to_string(gamepad_bindings[_index]);
			}
		} else {
			return "???";
		}
	});
	
	get_icon_index = method(self, function(_control_type, _index) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			var _icons = parent_menu.keyboard_icons[parent_menu.keyboard_icons_index];
			if (_index >= array_length(kbm_bindings)) {
				return sprite_get_number(_icons) - 1;
			} else if (discovery_binding_info
				&& discovery_binding_info.control_type == _control_type
				&& discovery_binding_info.control_index == _index) {
				return sprite_get_number(_icons) - 2;
			} else {
				return get_keyboard_icon_index(kbm_bindings[_index], _icons);
			}
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			var _icons = parent_menu.gamepad_icons[parent_menu.gamepad_icons_index];
			if (_index >= array_length(gamepad_bindings)) {
				return sprite_get_number(_icons) - 1;
			} else if (discovery_binding_info
				&& discovery_binding_info.control_type == _control_type
				&& discovery_binding_info.control_index == _index) {
				return sprite_get_number(_icons) - 2;
			} else {
				return get_gamepad_icon_index(gamepad_bindings[_index], _icons);
			}
		} else {
			return 0;
		}
	});
	
	verify_locked_bindings = method(self, function() {
		var _len = array_length(kbm_bindings);
		for (var _i=0; _i<_len; _i++) {
			locked_kbm_bindings[_i] = array_find(global.ugmls_disallowed_keyboard_controls, kbm_bindings[_i]) != -1;
		}
		
		_len = array_length(gamepad_bindings);
		for (var _i=0; _i<_len; _i++) {
			locked_gamepad_bindings[_i] = array_find(global.ugmls_disallowed_gamepad_controls, gamepad_bindings[_i]) != -1;
		}
	});
	
	set_binding_locked = method(self, function(_control_type, _index, _locked) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			locked_kbm_bindings[_index] = _locked;
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			locked_gamepad_bindings[_index] = _locked;
		}
	});
	
	get_binding_locked = method(self, function(_control_type, _index) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			return locked_kbm_bindings[_index];
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			return locked_gamepad_bindings[_index];
		}
		return -1;
	});
	
	verify_locked_bindings();
}