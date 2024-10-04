enum FLEX_MENU_CONTROLS {
	UP,
	DOWN,
	LEFT,
	RIGHT,
	CONFIRM,
	CANCEL,
	DELETE_BINDING,
	MAX
}

enum FLEX_MENU_DISCOVERY_MODE {
	NONE,
	SELECTING,
	DISCOVERING
}

enum FLEX_MENU_ITEM_TYPE {
	ITEM,
	DIVIDER,
	SELECTABLE,
	SPINNER_BASE,
	VALUED_SELECTABLE,
	SPINNER,
	KEY_CONFIG
}

function FlexMenuControlState(_player_inst = noone) constructor {
	pressed_state = [];
	held_state = [];
	player_inst = _player_inst;
	
	for (var _i=0; _i< FLEX_MENU_CONTROLS.MAX; _i++) {
		pressed_state[_i] = false;
		held_state[_i] = false;
	}
	
	function assign_player_inst(_player_inst) {
		player_inst = _player_inst;
	}
	
	function poll_input() {
		if (!instance_exists(player_inst)) return;
		
		pressed_state[FLEX_MENU_CONTROLS.UP] = player_inst.get_control_state(CONTROLS.UP, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.DOWN] = player_inst.get_control_state(CONTROLS.DOWN, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.LEFT] = player_inst.get_control_state(CONTROLS.LEFT, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.RIGHT] = player_inst.get_control_state(CONTROLS.RIGHT, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.CONFIRM] = player_inst.get_control_state(CONTROLS.MENU_CONFIRM, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.CANCEL] = player_inst.get_control_state(CONTROLS.MENU_CANCEL, CONTROL_STATE.PRESSED);
		pressed_state[FLEX_MENU_CONTROLS.DELETE_BINDING] = player_inst.get_control_state(CONTROLS.DELETE_BINDING, CONTROL_STATE.PRESSED);
	
		held_state[FLEX_MENU_CONTROLS.UP] = player_inst.get_control_state(CONTROLS.UP, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.DOWN] = player_inst.get_control_state(CONTROLS.DOWN, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.LEFT] = player_inst.get_control_state(CONTROLS.LEFT, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.RIGHT] = player_inst.get_control_state(CONTROLS.RIGHT, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.CONFIRM] = player_inst.get_control_state(CONTROLS.MENU_CONFIRM, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.CANCEL] = player_inst.get_control_state(CONTROLS.MENU_CANCEL, CONTROL_STATE.HELD);
		held_state[FLEX_MENU_CONTROLS.DELETE_BINDING] = player_inst.get_control_state(CONTROLS.DELETE_BINDING, CONTROL_STATE.HELD);
	}
	
	function control_any_pressed() {
		if (!instance_exists(player_inst)) return false;
		return player_inst.ctrl_any_pressed;
	}
}

/// @func  FlexMenuItem(config)
/// @param _config
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
function FlexMenuItem(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.ITEM;
	label = _config.label;
	root_node = _config.root_node;
	parent_menu = _config.parent_menu;
	menu_data = _config.menu_data;
	enabled = true;
	
	function can_interact() {
		return parent_menu.can_interact() && enabled;
	}
	
	function set_enabled(_enabled) {
		enabled = _enabled;
	}
	
	function get_label() {
		return label;
	}

	function destroy() {}
}

/// @func  FlexMenuDivider(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
function FlexMenuDivider(_config) : FlexMenuItem(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.DIVIDER;
}

/// @func  FlexMenuSelectable(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
//         - {string}      label
//         - {function}    on_confirm_func
//         - {array}       on_confirm_args
//         - {boolean}     silent_on_confirm
function FlexMenuSelectable(_config) : FlexMenuItem(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.SELECTABLE;
	on_confirm_func = _config.on_confirm_func;
	on_confirm_args = _config.on_confirm_args;
	silent_on_confirm = _config.silent_on_confirm;
	
	handle_confirm = method(self, function() {
		if (!can_interact()) return;
		if (is_callable(on_confirm_func)) {
			on_confirm_func(parent_menu, self, on_confirm_args);
		}

		if (!silent_on_confirm && audio_exists(parent_menu.cursor_confirm_sfx)) {
			audio_play_sound(parent_menu.cursor_confirm_sfx, 1, false);
		}
	});
}

/// @func  FlexMenuValuedSelectable(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
//         - {Pointer.FlexPanelNode} left_node
// 				 - {Pointer.FlexPanelNode} label_node
// 				 - {Pointer.FlexPanelNode} right_node
// 				 - {Pointer.FlexPanelNode} value_node
//         - {any}   init_value
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
function FlexMenuValuedSelectable(_config) : FlexMenuSpinnerBase(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.VALUED_SELECTABLE;
	value = _config.init_value;
	
	function get_value() {
		return value;
	}
	
	function set_value(_value) {
		value = _value;
		if (is_callable(on_change_func)) {
			on_change_func(parent_menu, self, value, on_change_args);
		}

		if (!silent_on_change && audio_exists(parent_menu.value_change_sfx)) {
			audio_play_sound(parent_menu.value_change_sfx, 1, false);
		}
	}
	
	function handle_confirm() {
		if (!can_interact()) return;
		if (is_callable(on_confirm_func)) {
			on_confirm_func(parent_menu, self, value, on_confirm_args);
		}

		if (!silent_on_confirm && audio_exists(parent_menu.cursor_confirm_sfx)) {
			audio_play_sound(parent_menu.cursor_confirm_sfx, 1, false);
		}
	}
}

/// @func  FlexMenuSpinnerBase(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
//         - {Pointer.FlexPanelNode} left_node
// 				 - {Pointer.FlexPanelNode} label_node
// 				 - {Pointer.FlexPanelNode} right_node
// 				 - {Pointer.FlexPanelNode} value_node
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
function FlexMenuSpinnerBase(_config) : FlexMenuSelectable(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.SPINNER_BASE;
	label_node = _config.label_node;
	left_node = _config.left_node;
	value_node = _config.value_node;
	right_node = _config.right_node;
	on_change_func = _config.on_change_func;
	on_change_args = _config.on_change_args;
	silent_on_change = _config.silent_on_change;
}

/// @func  FlexMenuValuedSelectable(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
//         - {Pointer.FlexPanelNode} left_node
// 				 - {Pointer.FlexPanelNode} label_node
// 				 - {Pointer.FlexPanelNode} right_node
// 				 - {Pointer.FlexPanelNode} value_node
//         - {array}    values
//         - {real}     init_index
//         - {bool}     lockable
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
function FlexMenuSpinner(_config) : FlexMenuSpinnerBase(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.SPINNER;
	lockable = _config.lockable ?? false;
	locked = lockable;
	var _num_values = array_length(_config.values);
	values = array_create(_num_values);
	array_copy(values, 0, _config.values, 0, _num_values);
	cur_index = clamp(_config.init_index, 0, _num_values - 1);
	
	function get_value() {
		return values[cur_index];
	}
	
	function set_value(_index, _call_on_change_func = false) {
		cur_index = clamp(_index, 0, array_length(values) - 1);
		if (_call_on_change_func && is_callable(on_change_func)) {
			on_change_func(
				parent_menu,
				self,
				cur_index,
				values[cur_index],
				0,
				on_change_args
			);
		}
	}
	
	function is_locked() {
		return lockable && locked;
	}
	
	function handle_change(_delta) {
		if (!can_interact()) return;
		if (is_locked()) return;

		var _num_values = array_length(values);
		cur_index = wrap(cur_index + _delta, 0, _num_values);
		
		if (is_callable(on_change_func)) {
			on_change_func(
				parent_menu,
				self,
				cur_index,
				values[cur_index],
				_delta,
				on_change_args
			);
		}
		
		if (!silent_on_change && audio_exists(parent_menu.value_change_sfx)) {
			audio_play_sound(parent_menu.value_change_sfx, 1, false);
		}
	}
	
	function handle_confirm() {
		if (!can_interact()) return;
		
		if (lockable) {
			locked = !locked;
		}
		
		if (is_callable(on_confirm_func)) {
			on_confirm_func(parent_menu, self, cur_index, values[cur_index], on_confirm_args);
		}

		if (!silent_on_confirm && audio_exists(parent_menu.cursor_confirm_sfx)) {
			audio_play_sound(parent_menu.cursor_confirm_sfx, 1, false);
		}
	}
}

/// @func  MenuKeyConfig(config)
/// @param _config 
//         - {Id.Instance} parent_menu
//				 - {string} label
//				 - {struct} menu_data
//         - {Pointer.FlexPanelNode} root_node
//         - {Pointer.FlexPanelNode} label_node
//         - {array}		binding_nodes
//         - {function} on_confirm_func
//         - {array}    on_confirm_args
//         - {function} on_change_func
//         - {array}    on_change_args
//         - {boolean}  silent_on_confirm
//         - {boolean}  silent_on_change
//         - {}         control
//         - {array}    initial_kbm_bindings
//         - {array}    initial_gamepad_bindings
/// @returns {Any}
function FlexMenuKeyConfig(_config) : FlexMenuSelectable(_config) constructor {
	type = FLEX_MENU_ITEM_TYPE.KEY_CONFIG;
	label_node = _config.label_node;
	binding_nodes = _config.binding_nodes;
	on_change_func = _config.on_change_func;
	on_change_args = _config.on_change_args;
	silent_on_change = _config.silent_on_change;
	control = _config.control;
	kbm_bindings = _config.initial_kbm_bindings;
	gamepad_bindings = _config.initial_gamepad_bindings;
	current_binding_index = 0;
	locked_kbm_bindings = array_create(array_length(_config.initial_kbm_bindings), false);
	locked_gamepad_bindings = array_create(array_length(_config.initial_gamepad_bindings), false);
	discovery_binding_info = false;
	
	function get_binding_info() {
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
	}
	
	function get_text_value(_control_type, _index) {
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
	}
	
	function get_icon_index(_control_type, _index) {
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
	}
	
	function verify_locked_bindings() {
		var _len = array_length(kbm_bindings);
		for (var _i=0; _i<_len; _i++) {
			locked_kbm_bindings[_i] = array_find(global.ugmls_disallowed_keyboard_controls, kbm_bindings[_i]) != -1;
		}
		
		_len = array_length(gamepad_bindings);
		for (var _i=0; _i<_len; _i++) {
			locked_gamepad_bindings[_i] = array_find(global.ugmls_disallowed_gamepad_controls, gamepad_bindings[_i]) != -1;
		}
	}
	
	function set_binding_locked(_control_type, _index, _locked) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			locked_kbm_bindings[_index] = _locked;
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			locked_gamepad_bindings[_index] = _locked;
		}
	}
	
	function get_binding_locked(_control_type, _index) {
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			return locked_kbm_bindings[_index];
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			return locked_gamepad_bindings[_index];
		}
		return -1;
	}
	
	/// @param {real}		_delta
	function handle_select(_delta) {
		if (!can_interact()) return;
		var _num_values = KEYBOARD_MAX_BINDINGS_PER_CONTROL + GAMEPAD_MAX_BINDINGS_PER_CONTROL;
		var _last_pressed = parent_menu.control_state.control_any_pressed();
		var _binding_info;
		var _original_value = current_binding_index;

		do {
			current_binding_index = wrap(current_binding_index + _delta, 0, _num_values);
			_binding_info = get_binding_info();
		} until (current_binding_index == _original_value || _last_pressed.control_type == _binding_info.control_type)

		if (current_binding_index != _original_value && !silent_on_change && audio_exists(parent_menu.cursor_move_sfx)) {
			audio_play_sound(parent_menu.cursor_move_sfx, 1, false);
		}
	}

	function handle_confirm() {
		// TODO: on_confirm_func is currently not used
		if (!can_interact()) return;
		var _last_pressed = parent_menu.control_state.control_any_pressed();	
	
		if (parent_menu.discovery_mode == MENU_DISCOVERY_MODE.NONE) {
			// Not selected
			if (_last_pressed.control_type == CONTROL_TYPE.GAMEPAD) {
				current_binding_index = KEYBOARD_MAX_BINDINGS_PER_CONTROL;
			} else {
				current_binding_index = 0;
			}
			parent_menu.discovery_mode = MENU_DISCOVERY_MODE.SELECTING;
			parent_menu.active_key_config = self;
		} else if (parent_menu.discovery_mode == MENU_DISCOVERY_MODE.SELECTING) {
			// Selecting
			var _binding_info = get_binding_info();
		
			if (_last_pressed.control_type != _binding_info.control_type) return;		
			if (_binding_info.binding_locked) return;

			parent_menu.discovery_mode = MENU_DISCOVERY_MODE.DISCOVERING;
			discovery_binding_info = _binding_info;
			io_clear();
		}
	}

	function handle_cancel() {
		if (!can_interact()) return;
		if (parent_menu.discovery_mode == MENU_DISCOVERY_MODE.SELECTING) {
			parent_menu.discovery_mode = MENU_DISCOVERY_MODE.NONE;
			parent_menu.active_key_config = -1;		
		}
	}

	function handle_delete() {
		if (!can_interact()) return;
		var _binding_info = get_binding_info();
		if (_binding_info.binding_locked) return;
	
		var _control_index = _binding_info.control_index;
		var _control_type = _binding_info.control_type;
		var _binding_key = "";

		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			_binding_key = kbm_bindings;
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			_binding_key = gamepad_bindings;
		} else {
			return;
		}
	
		_binding_key[_control_index] = -1;
		parent_menu.player_controller.remove_binding(_control_type, control, _control_index);
		parent_menu.discovery_mode = MENU_DISCOVERY_MODE.NONE;
		discovery_binding_info = false;
		parent_menu.active_key_config = -1;
	}

	function handle_discovery() {
		if (!can_interact()) return;
		if (parent_menu.control_state.pressed_state[MENU_CONTROLS.CANCEL]) {
			parent_menu.discovery_mode = MENU_DISCOVERY_MODE.SELECTING;
			discovery_binding_info = false;
			return;
		}

		var _control_type = discovery_binding_info.control_type;
		var _last_pressed = parent_menu.control_state.control_any_pressed();		
	
		if (_last_pressed != -1 && _last_pressed.control_type == _control_type) {
			var _control_index = discovery_binding_info.control_index;
			var _binding_key = "";		
		
			if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
				if (array_find(global.ugmls_disallowed_keyboard_controls, _last_pressed.control_pressed) != -1) return;
				_binding_key = kbm_bindings;
			} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
				if (array_find(global.ugmls_disallowed_gamepad_controls, _last_pressed.control_pressed) != -1) return;
				_binding_key = gamepad_bindings;
			} else {
				return;
			}		
		
			_binding_key[_control_index] = _last_pressed.control_pressed;
			parent_menu.player_controller.set_binding(_control_type, _last_pressed.control_source, control, _control_index, _last_pressed.control_pressed);
			parent_menu.discovery_mode = MENU_DISCOVERY_MODE.NONE;
			discovery_binding_info = false;

			if (is_callable(on_change_func)) {
				on_change_func(parent_menu, self, _control_type, _last_pressed.control_source, control, _control_index, _last_pressed.control_pressed, on_change_args);
			}

			parent_menu.active_key_config = -1;
			io_clear();
		}
	}
	
	verify_locked_bindings();
}