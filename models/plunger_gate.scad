//Block that the plunger rests in, and the ball rests in before it is launched into the playfield.

include <physical_dimensions.scad>

use <plunger_spring_stop.scad>

module plunger_gate() {
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
				cylinder(r=plunger_rod_radius + printing_play + movement_play, h=plunger_spring_compression + ball_radius + 0.1);
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

plunger_gate();