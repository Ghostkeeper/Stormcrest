//Plunger that launches the ball.

include <global_preferences.scad>
include <physical_dimensions.scad>

use <plunger_spring.scad>

//Preferences.
spring_stop_radius = 10; //Should be larger than spring's radius.
spring_stop_length = 10; //Length of coupling.
spring_stop_cone_length = 10; //Extra length of coupling that centres the rod in the gate.

translate([0, -cabinet_thickness - plunger_handle_overlap, ball_radius]) {
	rotate([-90, 0, 0]) {
		color(color_hardware) {
			cylinder(r=plunger_rod_radius, h=plunger_rod_length); //Main plunger rod.
		}
		translate([0, 0, -plunger_handle_height + plunger_handle_overlap]) {
			cylinder(r=plunger_handle_radius, h=plunger_handle_height); //Handle.
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
			union() {
				cylinder(r=spring_stop_radius, h=spring_stop_length);
				translate([0, 0, spring_stop_length]) {
					cylinder(r1=spring_stop_radius, r2=plunger_rod_radius, h=spring_stop_cone_length);
				}
			}
			cylinder(r=plunger_rod_radius + printing_play, h=spring_stop_length + spring_stop_cone_length);
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
				cylinder(r=spring_stop_radius + printing_play + movement_play, h=spring_stop_length);
				translate([0, 0, spring_stop_length]) {
					cylinder(r1=spring_stop_radius + printing_play + movement_play, r2=plunger_rod_radius + printing_play + movement_play, h=spring_stop_cone_length);
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