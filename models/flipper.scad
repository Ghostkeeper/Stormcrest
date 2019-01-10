use <flipper_bat.scad>
use <flipper_grip.scad>
use <flipper_solenoid.scad>
use <flipper_solenoid_brace.scad>
use <hexkey.scad>
use <spring.scad>
include <physical_dimensions.scad>

module flipper() {
	flipper_bat();
	translate([0, 0, -hexkey_long_length + ball_radius]) {
		hexkey();
	}
	translate([0, 0, -playfield_thickness]) {
		rotate([0, 180, 0]) {
			flipper_grip();
		}
	}
	solenoid_arm = flipper_solenoid_pin_expansion / 2 / sin(45 / 2);
	translate([-solenoid_arm, 0, -playfield_thickness - flipper_solenoid_height / 2 - flipper_solenoid_pingap_thickness / 2]) {
		rotate([0, 0, 90]) {
			flipper_solenoid_brace();
		}
	}
	rotate([0, 180, 0]) {
		translate([solenoid_arm, 50, playfield_thickness]) {
			flipper_solenoid();
		}
	}
	translate([60, 0, -playfield_thickness - 5 - spring_end_thickness / 2]) {
		rotate([90, 0, 180]) {
			spring();
		}
	}
}

//Debug.
flipper();