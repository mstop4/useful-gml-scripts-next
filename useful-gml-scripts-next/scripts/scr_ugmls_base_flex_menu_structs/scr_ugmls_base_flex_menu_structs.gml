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
//         - {}            node
function FlexMenuItem(_config) constructor {
	type = "item";
	node = _config.node;
	parent_menu = _config.parent_menu;
	enabled = true;
	
	function set_enabled(_enabled) {
		enabled = _enabled;
	}

	function destroy() {}
}