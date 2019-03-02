//Plunger that launches the ball.

include <global_preferences.scad>
include <physical_dimensions.scad>

use <plunger_handle.scad>
use <plunger_rod.scad>
use <plunger_spring.scad>
use <plunger_spring_stop.scad>

translate([0, -cabinet_thickness - plunger_handle_overlap, ball_radius]) {
	rotate([-90, 0, 0]) {
		color(color_hardware) {
			plunger_rod();
		}
		translate([0, 0, -plunger_handle_height + plunger_handle_overlap]) {
			plunger_handle();
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
	difference() {
		cube([lane_width, plunger_spring_compression + ball_radius, ball_radius * 2]);
		
		//Slot for spring stop.
		translate([lane_width / 2, 0, ball_radius]) {
			rotate([-90, 0, 0]) {
				minkowski() {
					hull() {
						plunger_spring_stop();
					}
					scale([1, 1, 0]) {
						cylinder(r=printing_play + movement_play, h=1);
					}
				}
			}
		}

		//Slot for rod.
		translate([lane_width / 2, 0, ball_radius]) {
			rotate([-90, 0, 0]) {
				cylinder(r=plunger_rod_radius + printing_play + movement_play, h=plunger_spring_compression + ball_radius * 2);
			}
		}

		//Resting place for ball waiting to be fired.
		hull() {
			translate([lane_width / 2, plunger_spring_compression + ball_radius + printing_play + movement_play, 0]) {
				cylinder(r=ball_radius + printing_play + movement_play, h=ball_radius * 2);
			}
			translate([0, plunger_spring_compression + ball_radius, -0.1]) {
				cube([lane_width, lane_width, ball_radius * 2 + 0.2]);
			}
		}
	}
}