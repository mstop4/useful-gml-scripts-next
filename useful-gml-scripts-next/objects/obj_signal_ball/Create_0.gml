x_spd = choose(-1, 1) * speed_multiplier;
y_spd = choose(-1, 1) * speed_multiplier;
x = irandom_range(sprite_width / 2, room_width - sprite_width / 2);
y = irandom_range(sprite_height / 2, room_height - sprite_height / 2);

function change_colour() {
	image_index = wrap(image_index + 1, 0, image_number - 1);
}

inst_signal_manager_demo_controller.signal_manager.add("change_colour", change_colour, false, id);