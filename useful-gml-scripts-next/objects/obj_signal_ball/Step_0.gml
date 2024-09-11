// Make ball bounce against the edges of the game window,
// each time it does, dispatch the "change_colour" signal
if (x + x_spd < sprite_width / 2) {
	x = sprite_width / 2;
	x_spd *= -1;
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
} else if (x + x_spd > room_width - sprite_width / 2) {
	x = room_width - sprite_width / 2;
	x_spd *= -1;
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
}

if (y + y_spd < sprite_height / 2) {
	y = sprite_height / 2;
	y_spd *= -1;
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
} else if (y + y_spd > room_height - sprite_height / 2) {
	y = room_height - sprite_height / 2;
	y_spd *= -1;
	inst_signal_manager_demo_controller.signal_manager.dispatch("change_colour");
}

x += x_spd;
y += y_spd;