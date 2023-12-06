inst_id_v = noone;
inst_id_h = noone;
inst_var_name_h = "";
inst_var_name_v = "";

nudger_assign_h = method(self, function(_inst_id, _inst_var_name) {
	self.inst_id_h = _inst_id;
	self.inst_var_name_h = _inst_var_name;
});

nudger_assign_v = method(self, function(_inst_id, _inst_var_name) {
	self.inst_id_v = _inst_id;
	self.inst_var_name_v = _inst_var_name;
});