draw_set_font(fnt_pixel_title);
draw_set_colour(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text(4, 4, "Compromise Scaler Demo");

draw_set_font(fnt_pixel_demo);
draw_text(4, 32, $"App Surface Res: {comp_scaler.app_res.x} x {comp_scaler.app_res.y}");
draw_text(4, 56, $"Current Window Size: {comp_scaler.cur_window_size.x} x {comp_scaler.cur_window_size.y}");
draw_text(4, 80, $"Saved Window Size: {comp_scaler.saved_window_size.x} x {comp_scaler.saved_window_size.y}");
draw_text(4, 104, $"Screen Mode: {mode_names[comp_scaler.fullscreen_mode]}");

draw_text(272, 32, $"Integer Scale: {comp_scaler.integer_scale}");
draw_text(272, 56, $"True Scale: {comp_scaler.true_scale}");

draw_text(4, 136, $"Press Left and Right Arrow to change resolution");
draw_text(4, 160, $"Press F to change screen mode");