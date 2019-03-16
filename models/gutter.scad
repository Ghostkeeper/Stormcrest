include <physical_dimensions.scad>

//Settings.
attachment_width = 30; //Width of the ledge that attaches the gutter to the bottom of the playfield.
num_screws = 7;

//Calculations.
gutter_width = lane_wall_thickness * 2 + ball_slit;
gutter_min_height = ball_radius * 2 + lane_wall_thickness + printing_play + movement_play;

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(lane_chamfer_radius < ball_radius); //Ball needs to fit between the chamfers.
	assert(attachment_width < gutter_min_height); //Attachment needs to be smaller than the size of the gutter.
	assert(attachment_width < gutter_width);
}

module _gutter_screw_hole() {
	rotate([90, 0, 0]) {
		cylinder(r=m3_bolt_radius, h=attachment_width * 2 / 3 - m3_nut_radius - printing_play - m3_nut_height);
		translate([0, 0, attachment_width * 2 / 3 - m3_nut_radius - printing_play - m3_nut_height]) {
			cylinder($fn=6, r=m3_nut_radius + printing_play, h=attachment_width);
		}
	}
}

module gutter() {
	difference() {
		//Main body.
		multmatrix(m=[[1, 0, 0, 0],
		              [0, 1, -tan(roll_slope), 0],
		              [0, 0, 1, 0],
		              [0, 0, 0, 1]]) {
			difference() {
				//Main body.
				union() {
					cube([gutter_width, gutter_min_height, printer_height]);
					multmatrix(m=[[1, 0, 0, 0],
					              [0, 1, tan(roll_slope), 0],
					              [0, 0, 1, 0],
					              [0, 0, 0, 1]]) {
						cube([gutter_width, gutter_min_height, printer_height]);
					}
					//Attachment piece.
					translate([gutter_width - attachment_width, gutter_min_height - attachment_width, 0]) {
						multmatrix(m=[[1, 1, 0, 0],
						              [0, 1, tan(roll_slope), 0],
						              [0, 0, 1, 0],
						              [0, 0, 0, 1]]) {
							cube([attachment_width, attachment_width, printer_height]);
						}
					}
				}

				//Hollow out a lane for the ball to roll through.
				translate([lane_wall_thickness + lane_chamfer_radius, lane_wall_thickness + lane_chamfer_radius, lane_wall_thickness + lane_chamfer_radius]) {
					minkowski() {
						cube([ball_slit - lane_chamfer_radius * 2, ball_radius * 4, printer_height]);
						sphere(r=lane_chamfer_radius);
					}
				}

				//Screw holes to align with lift.
				translate([lane_wall_thickness, lane_wall_thickness, printer_height - 10]) {
					cylinder(r=m3_bolt_radius, h=10.1);
				}
				translate([gutter_width - lane_wall_thickness, lane_wall_thickness, printer_height - 10]) {
					cylinder(r=m3_bolt_radius, h=10.1);
				}
			}
		}
		//Last alignment screw on the attachment piece.
		translate([gutter_width + attachment_width / 3, gutter_min_height - attachment_width / 3, printer_height - 10]) {
			cylinder(r=m3_bolt_radius, h=10.1);
		}

		//Screw holes.
		translate([gutter_width + attachment_width / 3, gutter_min_height, 0]) {
			for(i = [0 : num_screws - 1]) {
				translate([i % 2 == 0 ? attachment_width / 3 : 0, i % 2 == 0 ? attachment_width / 3 : 0, 10 + i * (printer_height - 20) / (num_screws - 1)]) {
					_gutter_screw_hole();
				}
			}
		}
	}
}

gutter();