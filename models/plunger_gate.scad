//Block that the plunger rests in, and the ball rests in before it is launched into the playfield.

include <physical_dimensions.scad>

use <plunger_cap.scad>

module plunger_gate() {
	gate_length = plunger_rod_length - cabinet_thickness - plunger_handle_overlap - plunger_spring_length;
	difference() {
		union() {
			translate([-lane_width / 2, -gate_length, -ball_radius]) {
				cube([lane_width, gate_length, ball_radius * 2]);
			}
			//Ball alignment.
			difference() {
				translate([-lane_width / 2, 0, -ball_radius]) {
					cube([lane_width, plunger_gate_alignment_length, ball_radius * 2]);
				}
				hull() {
					translate([0, ball_radius, -ball_radius - 0.1]) {
						cylinder(r=ball_radius, h=ball_radius * 2 + 0.2);
					}
					translate([-lane_width / 2, plunger_gate_alignment_length, -ball_radius]) {
						cube([lane_width, ball_radius * 2, ball_radius * 2]);
					}
				}
			}
		}

		//Slot that the rod cap slides in.
		minkowski() {
			hull() {
				plunger_cap();
			}
			scale([1, 1, 0]) {
				cylinder(r=printing_play + movement_play, h=1);
			}
		}
	}
}

plunger_gate();