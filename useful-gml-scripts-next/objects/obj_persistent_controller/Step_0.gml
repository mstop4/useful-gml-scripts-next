if (my_player.get_control_state(CONTROLS.EXIT, CONTROL_STATE.PRESSED)) {
	is_quitting = true;
} else if (my_player.get_control_state(CONTROLS.EXIT, CONTROL_STATE.RELEASED)) {
	is_quitting = false;
	quit_timer = quit_timer_length;
}

if (is_quitting) {
	quit_timer--;
	
	if (quit_timer <= 0) {
		quit_timer = quit_timer_length;
		is_quitting = false;
		if (room == room_title) game_end();
		else room_goto(room_title);
	}
}