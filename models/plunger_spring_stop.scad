//Plug that compresses the spring on the plunger.

include <physical_dimensions.scad>

module plunger_spring_stop() {
	difference() {
		union() {
			cylinder(r=plunger_spring_stop_radius, h=plunger_spring_stop_length);
			translate([0, 0, plunger_spring_stop_length]) {
				cylinder(r1=plunger_spring_stop_radius, r2=plunger_rod_radius, h=plunger_spring_stop_cone_length);
			}
		}
		cylinder(r=plunger_rod_radius, h=plunger_spring_stop_length + plunger_spring_stop_cone_length);
	}
}

plunger_spring_stop();