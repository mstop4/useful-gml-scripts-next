interpolate_hsv_base_colours = [make_color_hsv(0, 255, 255), make_color_hsv(192, 64, 64)];
interpolate_hsv_colours = [];
varied_colours = []

for (var _i=0; _i<=num_samples; _i++) {
	array_push(interpolate_hsv_colours, interpolate_hsv(
		interpolate_hsv_base_colours[0],
		interpolate_hsv_base_colours[1],
		_i / num_samples
	));
	
	array_push(varied_colours, vary_color_hsv(vary_colour_base_colour, irandom_range(-32,32), irandom_range(-32,32), irandom_range(-32,32)));
}

parsed_rgb_hexcode_string = rgb_hex_string_to_real(rgb_hexcode_str);

