//Plunger that launches the ball.

include <global_preferences.scad>
include <physical_dimensions.scad>

use <plunger_gate.scad>
use <plunger_handle.scad>
use <plunger_rod.scad>
use <plunger_spring.scad>
use <plunger_spring_stop.scad>

translate([0, -cabinet_thickness - plunger_handle_overlap, ball_radius]) {
	rotate([-90, 0, 0]) {
		color(color_hardware) {
			plunger_rod();
		}
		translate([0, 0, plunger_handle_overlap]) {
			rotate([180, 0, 0]) {
				plunger_handle();
			}
		}
		translate([0, 0, cabinet_thickness + plunger_handle_overlap]) {
			plunger_spring();
		}
	}
}

//Spring stop, which compresses the spring when pulling back the rod.
translate([0, plunger_rod_length - plunger_handle_overlap - cabinet_thickness - plunger_extension - plunger_spring_compression, ball_radius]) {
	rotate([-90, 0, 0]) {
		difference() {
			plunger_spring_stop();
		}
	}
}

//Guide and gate.
translate([-lane_width / 2, plunger_rod_length - plunger_handle_overlap - cabinet_thickness - plunger_extension - plunger_spring_compression, 0]) {
	plunger_gate();
}