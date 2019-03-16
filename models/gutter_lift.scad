include <physical_dimensions.scad>

//Settings.
extra_top_spacing = 10; //Because of inaccuracy of the ball movement, leave some extra space at the top to prevent the ball from hitting the playfield edge.
attachment_width = 30;

//Calculations.
gutter_width = lane_wall_thickness * 2 + ball_slit;
gutter_height = ball_radius * 2 + lane_wall_thickness + printing_play + movement_play + sin(roll_slope) * printer_height;
top_height = ball_radius * 2 + printing_play + movement_play + extra_top_spacing;

module gutter_lift() {
	difference() {
		union() {
			cube([gutter_width, gutter_width, gutter_height + playfield_thickness + top_height]); //Main body.

			//Attachment to the underside of the playfield.
			translate([0, gutter_width - attachment_width, gutter_height - attachment_width]) {
				multmatrix(m=[[1, 0, 0, 0],
				              [0, 1, 1, 0],
				              [0, 0, 1, 0],
				              [0, 0, 0, 1]]) {
					cube([gutter_width, attachment_width, attachment_width]);
				}
			}
		}

		//Hollow out bottom.
		translate([0, lane_wall_thickness + lane_chamfer_radius, lane_wall_thickness + lane_chamfer_radius]) {
			minkowski() {
				cube([gutter_width - lane_wall_thickness - lane_chamfer_radius, gutter_width - lane_wall_thickness * 2 - lane_chamfer_radius * 2, gutter_height - lane_chamfer_radius - lane_wall_thickness]);
				sphere(r=lane_chamfer_radius);
			}
		}

		//Hollow out middle.
		translate([lane_wall_thickness + lane_chamfer_radius, lane_wall_thickness + lane_chamfer_radius, gutter_height]) {
			minkowski() {
				cube([gutter_width - lane_chamfer_radius * 2 - lane_wall_thickness * 2, gutter_width - lane_chamfer_radius * 2 - lane_wall_thickness * 2, playfield_thickness + 0.1]);
				scale([1, 1, 0]) {
					cylinder(r=lane_chamfer_radius, h=1);
				}
			}
		}

		//Hollow out top.
		translate([lane_wall_thickness + lane_chamfer_radius, lane_wall_thickness + lane_chamfer_radius, gutter_height + playfield_thickness]) {
			minkowski() {
				cube([gutter_width - lane_chamfer_radius * 2 - lane_wall_thickness * 2, gutter_width - lane_chamfer_radius - lane_wall_thickness, top_height - (gutter_width - lane_wall_thickness)]);
				scale([1, 1, 0]) {
					cylinder(r=lane_chamfer_radius, h=1);
				}
			}
		}
		intersection() {
			translate([lane_wall_thickness + lane_chamfer_radius, gutter_width, gutter_height + playfield_thickness + top_height - gutter_width]) {
				rotate([0, 90, 0]) {
					minkowski() {
						cylinder(r=gutter_width - lane_wall_thickness - lane_chamfer_radius, h=gutter_width - lane_wall_thickness * 2 - lane_chamfer_radius * 2);
						sphere(r=lane_chamfer_radius);
					}
				}
			}
			translate([lane_wall_thickness, lane_wall_thickness, gutter_height + playfield_thickness + top_height - gutter_width]) {
				cube([gutter_width - lane_wall_thickness * 2, gutter_width - lane_wall_thickness + 0.1, top_height]);
			}
		}

		//Pin holes to attach to gutter.
		translate([-0.1, lane_wall_thickness, lane_wall_thickness * 2]) {
			rotate([0, 90, 0]) {
				cylinder(r=m3_bolt_radius, h=10.1);
			}
		}
		translate([-0.1, gutter_width - lane_wall_thickness, lane_wall_thickness * 2]) {
			rotate([0, 90, 0]) {
				cylinder(r=m3_bolt_radius, h=10.1);
			}
		}
		//Last alignment screw on the attachment piece.
		translate([-0.1, gutter_width + attachment_width / 3, gutter_height - attachment_width / 3]) {
			rotate([0, 90, 0]) {
				cylinder(r=m3_bolt_radius, h=10.1);
			}
		}
		//Screw hole to attach to underside of playfield.
		translate([gutter_width / 2, gutter_width + attachment_width * 2 / 3, gutter_height - attachment_width / 3]) {
			cylinder(r=m3_bolt_radius, h=attachment_width / 3 + 0.1);
		}
		translate([gutter_width / 2, gutter_width + attachment_width * 2 / 3, 0]) {
			cylinder(r=m3_nut_radius + printing_play, h=gutter_height - 8, $fn=6);
		}
	}
	//Plate above gutter (because we hollowed out too much in the bottom).
	translate([0, lane_wall_thickness, gutter_height]) {
		cube([lane_wall_thickness, gutter_width - lane_wall_thickness * 2, lane_chamfer_radius]);
	}
}

gutter_lift();