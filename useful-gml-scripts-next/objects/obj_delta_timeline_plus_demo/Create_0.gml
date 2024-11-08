multipliers = [0.5, 1, 2, 4];
cur_multiplier = 1;

red_timeline = new DeltaTimelinePlus();
num_red_lights = 0;

red_timeline.add_moment(60, true, method(self, function() {
	num_red_lights++;
}), false);

red_timeline.add_moment(120, true, method(self, function() {
	num_red_lights++;
}), false);

red_timeline.add_moment(180, true, method(self, function() {
	num_red_lights++;
}), false);

red_timeline.add_moment(240, true, method(self, function() {
	num_red_lights++;
}), false);

red_timeline.add_moment(300, true, method(self, function() {
	num_red_lights++;
}), false);

red_timeline.add_moment(360, true, method(self, function() {
	num_red_lights++;
}), false);

blue_timeline = new DeltaTimelinePlus();
num_blue_lights = 0;

blue_timeline.add_moment(1, false, method(self, function() {
	num_blue_lights++;
}), false);

blue_timeline.add_moment(2, false, method(self, function() {
	num_blue_lights++;
}), false);

blue_timeline.add_moment(3, false, method(self, function() {
	num_blue_lights++;
}), false);

blue_timeline.add_moment(4, false, method(self, function() {
	num_blue_lights++;
}), false);

blue_timeline.add_moment(5, false, method(self, function() {
	num_blue_lights++;
}), false);

blue_timeline.add_moment(6, false, method(self, function() {
	num_blue_lights++;
}), false);