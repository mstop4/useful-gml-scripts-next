draw_set_colour(c_white);
draw_set_alpha(1);

draw_set_font(fnt_title);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_text(room_width/2, 16, "Debugging Demo");

draw_set_font(fnt_demo);
draw_set_halign(fa_left);
draw_text(16, 64, "print() - Please check the the Output tab (testing builds only).");