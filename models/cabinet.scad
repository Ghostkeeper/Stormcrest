include <global_preferences.scad>
include <physical_dimensions.scad>

//Preferences.
matrix_spacing = 40; //How much spacing to leave around the LED matrix.

//Calculations.
inner_length = cos(playfield_slope) * (playfield_height + ball_slit);
slope_height = sin(playfield_slope) * (playfield_height + ball_slit);
slope_top = asin((slope_height + space_top_back - space_top) / (playfield_height + ball_slit + cabinet_thickness * 2));

module cabinet_plank() {
	color(color_wood) {
		rotate([slope_top, 0, 0]) {
			difference() {
				cube([cabinet_thickness, cabinet_plank_length, cabinet_plank_width]);
				rotate([90 - slope_top, 0, 0]) {
					cube([cabinet_thickness, cabinet_plank_length, cabinet_plank_length]);
				}
			}
		}
	}
}

module cabinet() {
	stacked_height = cabinet_plank_width / sin(90 - slope_top);

	//Left side.
	translate([0, 0, -stacked_height * 2 + space_bottom + space_top + playfield_thickness]) {
		cabinet_plank();
		translate([0, 0, stacked_height + 1]) { //1mm extra just so you can see the separate planks in preview.
			cabinet_plank();
		}
	}

	//Right side.
	translate([playfield_width + playfield_thickness, 0, -stacked_height * 2 + space_bottom + space_top + playfield_thickness]) {
		cabinet_plank();
		translate([0, 0, stacked_height + 1]) {
			cabinet_plank();
		}
	}

	color(color_wood) {
		//Front side.
		translate([playfield_thickness, 0, space_bottom + space_top + playfield_thickness - cabinet_plank_width]) {
			cube([playfield_width, cabinet_thickness, cabinet_plank_width]);
		}
		translate([playfield_thickness, 0, space_bottom + space_top + playfield_thickness - cabinet_plank_width * 2 - 1]) { //1mm extra just so you can see the separate planks.
			cube([playfield_width, cabinet_thickness, cabinet_plank_width]);
		}

		//Back side.
		translate([playfield_thickness, inner_length + cabinet_thickness, slope_height + space_bottom + playfield_thickness + space_top_back - cabinet_plank_width]) {
			cube([playfield_width, cabinet_thickness, cabinet_plank_width]);
		}
		translate([playfield_thickness, inner_length + cabinet_thickness, slope_height + space_bottom + playfield_thickness + space_top_back - cabinet_plank_width * 2 - 1]) {
			cube([playfield_width, cabinet_thickness, cabinet_plank_width]);
		}

		//Playfield.
		translate([cabinet_thickness, cabinet_thickness + ball_slit, space_bottom]) {
			rotate([playfield_slope, 0, 0]) {
				translate([0, 0, -playfield_thickness]) {
					cube([playfield_width, playfield_height, playfield_thickness]);
				}
			}
		}

		//Back panel, with hole for LED matrix.
		translate([0, inner_length + cabinet_thickness, slope_height + space_bottom + playfield_thickness + space_top_back]) {
			difference() {
				cube([playfield_width + cabinet_thickness * 2, cabinet_thickness, matrix_spacing * 2 + matrix_size[1]]);
				translate([playfield_width / 2 + cabinet_thickness - matrix_size[0] / 2, -0.1, matrix_spacing]) {
					cube([matrix_size[0], cabinet_thickness + 0.2, matrix_size[1]]);
				}
			}
		}
	}
}

cabinet();

//For cutting, output the cabinet's dimensions:
echo(str("Cabinet wood dimensions:\n  Front: ", playfield_width, " by ", space_bottom + space_top + playfield_thickness, "\n  Back: ", playfield_width, " by ", slope_height + space_bottom + playfield_thickness + space_top_back + matrix_spacing * 2 + matrix_size[1], "\n  Depth: ", inner_length + cabinet_thickness * 2, "\n  Slope up top: ", asin((slope_height + space_top_back - space_top) / (playfield_height + ball_slit + cabinet_thickness * 2)), "deg\n  Side height: ", slope_height + space_bottom + playfield_thickness + space_top_back));