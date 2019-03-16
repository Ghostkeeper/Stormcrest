include <physical_dimensions.scad>

//Settings.
extra_top_spacing = 10; //Because of inaccuracy of the ball movement, leave some extra space at the top to prevent the ball from hitting the playfield edge.

//Calculations.
gutter_width = lane_wall_thickness * 2 + ball_slit;
gutter_height = ball_radius * 2 + lane_wall_thickness + printing_play + movement_play + sin(roll_slope) * printer_height;
top_height = ball_radius * 2 + printing_play + movement_play + extra_top_spacing;

module gutter_lift() {
	difference() {
		cube([gutter_width, gutter_width, gutter_height + playfield_thickness + top_height]); //Main body.

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
		translate([0, lane_wall_thickness, lane_wall_thickness * 2]) {
			rotate([0, 90, 0]) {
				cylinder(r=m3_bolt_radius, h=10);
			}
		}
		translate([0, gutter_width - lane_wall_thickness, lane_wall_thickness * 2]) {
			rotate([0, 90, 0]) {
				cylinder(r=m3_bolt_radius, h=10);
			}
		}
	}
	//Plate above gutter (because we hollowed out too much in the bottom).
	translate([0, lane_wall_thickness, gutter_height]) {
		cube([lane_wall_thickness, gutter_width - lane_wall_thickness * 2, lane_chamfer_radius]);
	}
}

gutter_lift();