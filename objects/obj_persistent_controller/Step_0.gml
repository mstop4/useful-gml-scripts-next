if (my_player.get_control_state(CONTROLS.EXIT, CONTROL_STATE.HELD)) {
	quit_timer--;
	
	if (quit_timer <= 0) {
		quit_timer = quit_timer_length;
		my_player.clear_all_input();
		io_clear();
		if (room == room_title) game_end();
		else room_goto(room_title);
	}
}

else if (my_player.get_control_state(CONTROLS.EXIT, CONTROL_STATE.RELEASED)) {
	quit_timer = quit_timer_length;
}