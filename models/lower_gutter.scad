include <physical_dimensions.scad>

//Calculations.
roll_height = sin(roll_slope) * (printer_width * 2 - lane_connector_length - lane_wall_thickness);

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(lane_chamfer_radius < ball_radius);
}

module lower_gutter() {
	difference() {
		//Main body.
		cube([lane_wall_thickness * 2 + ball_slit, printer_width, ball_radius * 2 + lane_wall_thickness + roll_height]);
		rotate([roll_slope, 0, 0]) {
			translate([lane_wall_thickness, 0                                                                                                                                                                   , lane_chamfer_radius + lane_wall_thickness]) {
				cube([ball_slit, printer_width * 2, ball_radius * 2 + roll_height]);
			}

			//Left chamfer.
			translate([lane_wall_thickness + lane_chamfer_radius, 0, lane_wall_thickness + lane_chamfer_radius]) {
				rotate([-90, 0, 0]) {
					cylinder(r=lane_chamfer_radius, h=printer_width * 2);
				}
			}
			//Flat bottom between chamfers.
			translate([lane_wall_thickness + lane_chamfer_radius, 0, lane_wall_thickness]) {
				cube([ball_slit - lane_chamfer_radius * 2, printer_width * 2, lane_chamfer_radius]);
			}
			//Right chamfer.
			translate([lane_wall_thickness + ball_slit - lane_chamfer_radius, 0, lane_wall_thickness + lane_chamfer_radius]) {
				rotate([-90, 0, 0]) {
					cylinder(r=lane_chamfer_radius, h=printer_width * 2);
				}
			}
		}
	}
}

lower_gutter();