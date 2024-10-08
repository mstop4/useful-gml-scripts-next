function reset_all_control_bindings(_player) {
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.UP, 0, vk_up);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.DOWN, 0, vk_down);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.LEFT, 0, vk_left);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.RIGHT, 0, vk_right);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.SHOOT, 0, ord("Z"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.JUMP, 0, ord("X"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.INTERACT, 0, ord("C"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.ITEM, 0, ord("V"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.EXIT, 0, vk_escape);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_UP, 0, vk_up);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_DOWN, 0, vk_down);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_LEFT, 0, vk_left);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_RIGHT, 0, vk_right);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_CONFIRM, 0, vk_enter);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_CANCEL, 0, vk_backspace);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.DELETE_BINDING, 0, vk_delete);

	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.UP, 1, ord("W"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.DOWN, 1, ord("S"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.LEFT, 1, ord("A"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.RIGHT, 1, ord("D"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.SHOOT, 1, ord("L"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.JUMP, 1, vk_semicolon);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.INTERACT, 1, vk_single_quote);
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.ITEM, 1, ord("P"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_UP, 1, ord("W"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_DOWN, 1, ord("S"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_LEFT, 1, ord("A"));
	_player.set_binding(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROL_SOURCE.KEYBOARD, CONTROLS.MENU_RIGHT, 1, ord("D"));

	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.UP, 0,  gp_padu);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.DOWN, 0,  gp_padd);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.LEFT, 0, gp_padl);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.RIGHT, 0, gp_padr);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.SHOOT, 0, gp_face3);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.JUMP, 0, gp_face1);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.INTERACT, 0, gp_face2);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.ITEM, 0, gp_face4);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.EXIT, 0, gp_select);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_UP, 0, gp_padu);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_DOWN, 0, gp_padd);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_LEFT, 0, gp_padl);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_RIGHT, 0, gp_padr);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_CONFIRM, 0, gp_face1);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.MENU_CANCEL, 0, gp_face2);
	_player.set_binding(CONTROL_TYPE.GAMEPAD, CONTROL_SOURCE.GAMEPAD, CONTROLS.DELETE_BINDING, 0, gp_select);
}