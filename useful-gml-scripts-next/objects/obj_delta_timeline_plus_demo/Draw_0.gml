draw_set_colour(c_white);
draw_set_font(fnt_title);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(16, 16, "Delta Timeline Plus");

draw_set_font(fnt_demo);
draw_text(16, 64, $"Current Time Step Multiplier: {multipliers[cur_multiplier]}");

draw_set_color(c_red);
for (var _i=0; _i<num_red_lights; _i++) {
	draw_circle(32 + _i*64, 128, 8, false);
}

draw_set_color(c_blue);
for (var _i=0; _i<num_blue_lights; _i++) {
	draw_circle(32 + _i*64, 160, 8, false);
}