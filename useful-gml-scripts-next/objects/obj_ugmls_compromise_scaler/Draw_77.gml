gpu_set_colorwriteenable(1, 1, 1, 0);

surface_set_target(upscale_surf);
draw_clear(c_black);
draw_surface_ext(application_surface, 0, 0, integer_scale, integer_scale, 0, c_white, 1);
surface_reset_target();

gpu_set_texfilter(true);

draw_surface_stretched(upscale_surf, 0, 0, screen_size.x, screen_size.y);
gpu_set_colorwriteenable(1, 1 ,1, 1);
gpu_set_texfilter(false);