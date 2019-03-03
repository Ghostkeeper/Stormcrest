//Block that the plunger rests in, and the ball rests in before it is launched into the playfield.

include <physical_dimensions.scad>

use <plunger_cap.scad>

module plunger_gate() {
	gate_length = plunger_rod_length - cabinet_thickness - plunger_handle_overlap - plunger_spring_length;
	slope_height = sin(playfield_slope) * (gate_length + plunger_gate_alignment_length);
	difference() {
		union() {
			translate([-lane_width / 2, -gate_length, -ball_radius - slope_height]) {
				cube([lane_width, gate_length, ball_radius * 2 + slope_height]);
			}
			//Ball alignment.
			difference() {
				translate([-lane_width / 2, 0, -ball_radius - slope_height]) {
					cube([lane_width, plunger_gate_alignment_length, ball_radius * 2 + slope_height]);
				}
				hull() {
					translate([0, ball_radius, -ball_radius - slope_height - 0.1]) {
						cylinder(r=ball_radius, h=ball_radius * 2 + slope_height + 0.2);
					}
					translate([-lane_width / 2, plunger_gate_alignment_length, -ball_radius - slope_height]) {
						cube([lane_width, ball_radius * 2, ball_radius * 2 + slope_height]);
					}
				}
			}
		}
		//Creating the playfield slope at the bottom.
		translate([-lane_width / 2 - 0.1, 0, -ball_radius]) {
			rotate([180 + playfield_slope, 0, 0]) {
				translate([0, -plunger_gate_alignment_length, 0]) {
					cube([lane_width + 0.2, (gate_length + plunger_gate_alignment_length) * 2, slope_height * 2]);
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

		//Screw holes.
		horizontal_offset = ball_radius + (lane_width / 2 - ball_radius) / 2;
		rotate([playfield_slope, 0, 0]) {
			translate([-horizontal_offset, -gate_length / 2, -ball_radius - slope_height - 0.1]) {
				cylinder(r=m3_bolt_radius, h=20 + 0.1); //Fits M3x20.
			}
			translate([horizontal_offset, -gate_length / 2, -ball_radius - slope_height - 0.1]) {
				cylinder(r=m3_bolt_radius, h=20 + 0.1);
			}
		}
	}
}

plunger_gate();