include <physical_dimensions.scad>
include <global_preferences.scad>

module solenoid(expansion = 0) {
	color(color_electronics) {
		difference() {
			union() {
				translate([-solenoid_width / 2, solenoid_pin_retracted - solenoid_pinhole_position]) {
					cube([solenoid_width, solenoid_length, solenoid_height]);
				}
				translate([0, solenoid_pin_retracted - solenoid_pinhole_position, solenoid_height / 2]) {
					rotate([90, 0, 0]) {
						cylinder(r=solenoid_pin_radius, h=solenoid_pin_retracted + expansion);
					}
				}
			}
			translate([0, -expansion, 0]) { //Pin hole.
				cylinder(r=solenoid_pinhole_radius, h=solenoid_height);
			}
			translate([-solenoid_pin_radius, -solenoid_pinhole_position - expansion, solenoid_height / 2 - solenoid_pingap_thickness / 2]) {
				cube([solenoid_pin_radius * 2, solenoid_pingap_depth, solenoid_pingap_thickness]);
			}
			translate([0, solenoid_pin_retracted - solenoid_pinhole_position + solenoid_screw1_position, 0]) {
				cylinder(r=solenoid_screw_radius, h=solenoid_screw_depth);
			}
			translate([0, solenoid_pin_retracted - solenoid_pinhole_position + solenoid_screw2_position, 0]) {
				cylinder(r=solenoid_screw_radius, h=solenoid_screw_depth);
			}
		}
	}
}

solenoid($t * 10);