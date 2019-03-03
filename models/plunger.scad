//Plunger that launches the ball.

include <global_preferences.scad>
include <physical_dimensions.scad>

use <plunger_gate.scad>
use <plunger_handle.scad>
use <plunger_rod.scad>
use <plunger_spring.scad>
use <plunger_cap.scad>

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
	
	translate([0, plunger_rod_length, 0]) {
		plunger_cap();
		plunger_gate();
	}
}