if (room == room_compromise_scaler_demo) {
	draw_set_font(fnt_pixel_demo);
} else {
	draw_set_font(fnt_demo);
}

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_colour(c_white);
draw_text(room_width, room_height, "Hold \"Esc\" to quit");

if (quit_timer < quit_timer_length) {
	var _percentage = 1 - (quit_timer / quit_timer_length);
	draw_curved_meter(surf_quit_meter, 16, 16, 12, 16, 0, 360, -1, _percentage, c_white, #404040, spr_donut_meter, 100);
	draw_surface(surf_quit_meter, room_width - 40, room_height - 64);
}