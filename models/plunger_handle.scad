//Handle of the plunger.

include <physical_dimensions.scad>

module plunger_handle() {
	//TODO: Need to model this into something more fancy.
	difference() {
		cylinder(r=plunger_handle_radius, h=plunger_handle_height);
		cylinder(r=plunger_rod_radius + printing_play, h=plunger_handle_overlap);
	}
}

plunger_handle();