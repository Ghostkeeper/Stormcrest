include <physical_dimensions.scad>

//Settings.
attachment_width = 30; //Width of the ledge that attaches the gutter to the bottom of the playfield.

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(lane_chamfer_radius < ball_radius); //Ball needs to fit between the chamfers.
	assert(attachment_width < ball_radius * 2 + lane_wall_thickness + printing_play + movement_play); //Attachment needs to be smaller than the height of the gutter.
	assert(attachment_width < lane_wall_thickness * 2 + ball_slit);
}

module gutter() {
	//Main body.
	multmatrix(m=[[1, 0, 0, 0],
	              [0, 1, -tan(roll_slope), 0],
	              [0, 0, 1, 0],
	              [0, 0, 0, 1]]) {
		difference() {
			//Main body.
			union() {
				cube([lane_wall_thickness * 2 + ball_slit, ball_radius * 2 + lane_wall_thickness + printing_play + movement_play, printer_height]);
				multmatrix(m=[[1, 0, 0, 0],
				              [0, 1, tan(roll_slope), 0],
				              [0, 0, 1, 0],
				              [0, 0, 0, 1]]) {
					cube([lane_wall_thickness * 2 + ball_slit, ball_radius * 2 + lane_wall_thickness + printing_play + movement_play, printer_height]);
				}
				//Attachment piece.
				translate([lane_wall_thickness * 2 + ball_slit - attachment_width, ball_radius * 2 + lane_wall_thickness + printing_play + movement_play - attachment_width, 0]) {
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
		}
	}
}

gutter();