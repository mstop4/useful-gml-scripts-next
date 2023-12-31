draw_set_colour(c_white);
draw_set_alpha(1);

draw_set_font(fnt_title);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text(16, 16, "Geometry (Laser) Demo");
draw_set_font(fnt_demo);
draw_set_halign(fa_right);
draw_text(room_width - 16, 16, "Hold LMB and drag to move laser source\nHold RMB and drag to move laser target");

draw_line(reflector.a.x, reflector.a.y, reflector.b.x, reflector.b.y);

draw_set_colour(c_lime);
draw_circle(laser.a.x, laser.a.y, 8, false);

if (can_reflect) {
	draw_set_alpha(0.25);
	draw_line(laser.a.x, laser.a.y, laser.b.x, laser.b.y);
	draw_set_colour(c_white);
	draw_circle(laser.b.x, laser.b.y, 4, false);
	draw_set_colour(c_lime);
	draw_set_alpha(1);
	draw_circle(reflected_laser.a.x, reflected_laser.a.y, 4, false);
	draw_line(laser.a.x, laser.a.y, reflected_laser.a.x, reflected_laser.a.y);
	draw_line(reflected_laser.a.x, reflected_laser.a.y, reflected_laser.b.x, reflected_laser.b.y);
	draw_circle(reflected_laser.b.x, reflected_laser.b.y, 8, false);
} else {
	draw_set_alpha(1);
	draw_line(laser.a.x, laser.a.y, laser.b.x, laser.b.y);
	draw_set_colour(c_white);
	draw_circle(laser.b.x, laser.b.y, 4, false);
}