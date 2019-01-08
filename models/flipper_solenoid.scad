include <physical_dimensions.scad>

module flipper_solenoid(expansion = 0) {
	difference() {
		union() {
			translate([-flipper_solenoid_width / 2, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position]) {
				cube([flipper_solenoid_width, flipper_solenoid_length, flipper_solenoid_height]);
			}
			translate([0, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position, flipper_solenoid_height / 2]) {
				rotate([90, 0, 0]) {
					cylinder(r=flipper_solenoid_pin_radius, h=flipper_solenoid_pin_retracted + expansion);
				}
			}
		}
		translate([0, -expansion, 0]) { //Pin hole.
			cylinder(r=flipper_solenoid_pinhole_radius, h=flipper_solenoid_height);
		}
		translate([-flipper_solenoid_pin_radius, -flipper_solenoid_pinhole_position - expansion, flipper_solenoid_height / 2 - flipper_solenoid_pingap_thickness / 2]) {
			cube([flipper_solenoid_pin_radius * 2, flipper_solenoid_pingap_depth, flipper_solenoid_pingap_thickness]);
		}
		translate([0, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position + flipper_solenoid_screw1_position, 0]) {
			cylinder(r=flipper_solenoid_screw_radius, h=flipper_solenoid_screw_depth);
		}
		translate([0, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position + flipper_solenoid_screw2_position, 0]) {
			cylinder(r=flipper_solenoid_screw_radius, h=flipper_solenoid_screw_depth);
		}
	}
}

flipper_solenoid($t * 10);