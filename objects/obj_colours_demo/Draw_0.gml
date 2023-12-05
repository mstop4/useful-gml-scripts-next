draw_set_font(fnt_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_text(room_width/2, 16, "Colours Demo");

draw_set_halign(fa_left);
draw_text(16, 64, "Interpolate HSV");
draw_text(16, 144, "Parse RGB Hexcode String to BGR Format");
draw_text(16, 224, "Vary Colour Using HSV Channels");

draw_set_font(fnt_demo);
draw_set_colour(parsed_rgb_hexcode_string);
draw_text(16, 176, $"{rgb_hexcode_str} = {parsed_rgb_hexcode_string}");

for (var _i=0; _i<=num_samples; _i++) {
	draw_set_colour(interpolate_hsv_colours[_i]);
	draw_rectangle(16 + _i*48, 96, 48 + _i*48, 128, false);
	
	draw_set_colour(varied_colours[_i]);
	draw_rectangle(16 + _i*48, 256, 48 + _i*48, 288, false);
}

draw_set_colour(vary_colour_base_colour);
draw_rectangle(16 + (num_samples+1)*48, 256, 48 + (num_samples+1)*48, 288, false);