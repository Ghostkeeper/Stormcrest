include <physical_dimensions.scad>

//Preference settings.
grip_side_radius = flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position;
length = 50;

module flipper_solenoid_brace() {
	difference() {
		hull() {
			cylinder(r=grip_side_radius, h=flipper_solenoid_pingap_thickness);
			translate([length, 0, 0]) {
				cylinder(r=flipper_solenoid_pingap_depth - flipper_solenoid_pinhole_position, h=flipper_solenoid_pingap_thickness);
			}
		}
		cylinder(r=m3_bolt_radius, h=flipper_solenoid_pingap_thickness);
		translate([length, 0, 0]) {
			cylinder(r=m3_bolt_radius, h=flipper_solenoid_pingap_thickness);
		}
	}
}

//Debug.
flipper_solenoid_brace();