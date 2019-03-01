//Plunger that launches the ball.

include <global_preferences.scad>
include <physical_dimensions.scad>

//Preferences.
extension = 5; //How far the rod extends beyond the gate (in resting position) to give the ball a push.
compression = 30; //How far the spring can be compressed.

translate([0, -cabinet_thickness - plunger_handle_overlap, ball_radius]) {
	rotate([-90, 0, 0]) {
		color(color_hardware) {
			cylinder(r=plunger_rod_radius, h=plunger_rod_length); //Main plunger rod.
		}
		translate([0, 0, -plunger_handle_height + plunger_handle_overlap]) {
			cylinder(r=plunger_handle_radius, h=plunger_handle_height); //Handle.
		}
		translate([0, 0, cabinet_thickness + plunger_handle_overlap]) {
			color(color_hardware) {
				linear_extrude(twist=5000, height=plunger_rod_length - plunger_handle_overlap - cabinet_thickness - extension - compression) {
					translate([plunger_rod_radius * 2, 0, 0]) {
						circle(r=1);
					}
				}
			}
		}
	}
}

//Guide and gate.
translate([-lane_width / 2, plunger_rod_length - plunger_handle_overlap - cabinet_thickness - extension - compression, 0]) {
	difference() {
		cube([lane_width, compression + ball_radius, ball_radius * 2]);
		translate([lane_width / 2, 0, ball_radius]) {
			rotate([-90, 0, 0]) {
				cylinder(r=plunger_rod_radius + printing_play + movement_play, h=compression + ball_radius * 2);
			}
		}
		hull() {
			translate([lane_width / 2, compression + ball_radius + printing_play + movement_play, 0]) {
				cylinder(r=ball_radius + printing_play + movement_play, h=ball_radius * 2);
			}
			translate([0, compression + ball_radius, -0.1]) {
				cube([lane_width, lane_width, ball_radius * 2 + 0.2]);
			}
		}
	}
}