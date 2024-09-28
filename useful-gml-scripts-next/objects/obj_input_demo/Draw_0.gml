draw_set_font(fnt_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_text(room_width/2, 16, "Input Demo");

draw_text(room_width/2, 80, "The last key you pressed was:");
draw_text(room_width/2, 352, "The last button you pressed was:");
draw_set_font(fnt_demo);
draw_text(room_width/2, 112, $"{keycode_to_string(keyboard_lastkey)}\nNative Keycode: {string(keyboard_lastkey)}\nJS Keycode: {translate_native_to_js_keycode(keyboard_lastkey)}");
draw_sprite(spr_keyboard_icons_legacy, get_keyboard_icon_index(keyboard_lastkey, spr_keyboard_icons_legacy), room_width/2 - icon_half_size, 256 - icon_half_size);

// Feather disable once GM1029
draw_text(room_width/2, 384, string(last_button) + " - " + gamepad_constant_to_string(last_button));
draw_sprite(spr_xbox_series_gamepad_icons_legacy, get_gamepad_icon_index(last_button, spr_xbox_series_gamepad_icons_legacy), room_width/2 - icon_half_size, 464 - icon_half_size);