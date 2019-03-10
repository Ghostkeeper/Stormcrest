include <physical_dimensions.scad>

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(lane_chamfer_radius < ball_radius);
}

module gutter() {
	multmatrix(m=[[1, 0, 0, 0],
	              [0, 1, -tan(roll_slope), 0],
	              [0, 0, 1, 0],
	              [0, 0, 0, 1]]) {
		difference() {
			union() {
				cube([lane_wall_thickness * 2 + ball_slit, ball_radius * 2 + lane_wall_thickness + printing_play + movement_play, printer_height]);
				multmatrix(m=[[1, 0, 0, 0],
				               [0, 1, tan(roll_slope), 0],
				               [0, 0, 1, 0],
				               [0, 0, 0, 1]]) {
					cube([lane_wall_thickness * 2 + ball_slit, ball_radius * 2 + lane_wall_thickness + printing_play + movement_play, printer_height]);
				}
			}
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