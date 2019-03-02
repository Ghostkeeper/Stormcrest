//Main rod of the plunger.

include <global_preferences.scad>
include <physical_dimensions.scad>

module plunger_rod() {
	color(color_hardware) {
		cylinder(r=plunger_rod_radius, h=plunger_rod_length);
	}
}

plunger_rod();