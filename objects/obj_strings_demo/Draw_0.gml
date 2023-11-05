draw_set_colour(c_lime);
draw_line(16, 208, 16, 232);
draw_line(336, 208, 336, 232);

draw_line(16, 304, 16, 328);
draw_line(816, 304, 816, 328);

draw_line(16, 400, 16, 480);
draw_line(216, 400, 216, 480);

draw_set_font(fnt_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_text(room_width/2, 16, "Strings Demo");

draw_set_halign(fa_left);
draw_text(16, 64, "Original String");
draw_text(16, 160, "Hide Overflow (over 320px)");
draw_text(16, 256, "Pad String Width (to 800px)");
draw_text(16, 352, "Dialogue Line Breaker (to 200px width)");

draw_set_font(fnt_demo);

draw_text(16, 112, original_str);
draw_text(16, 208, hide_overflow_str);
draw_text(16, 304, pad_str);
draw_text(16, 400, dialogue_str);