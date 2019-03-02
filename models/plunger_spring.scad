include <global_preferences.scad>
include <physical_dimensions.scad>

module plunger_spring() {
	color(color_hardware) {
		linear_extrude(twist=5000, height=plunger_rod_length - plunger_handle_overlap - cabinet_thickness - plunger_extension - plunger_spring_compression) {
			translate([plunger_rod_radius * 2, 0, 0]) {
				circle(r=1);
			}
		}
	}
}

plunger_spring();