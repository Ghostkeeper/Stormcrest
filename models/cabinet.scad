include <global_preferences.scad>
include <physical_dimensions.scad>

//Preferences.
matrix_spacing = 40; //How much spacing to leave around the LED matrix.

//Calculations.
inner_length = cos(playfield_slope) * (playfield_height + ball_slit);
slope_height = sin(playfield_slope) * (playfield_height + ball_slit);

module cabinet() {
	color(color_wood) {
		difference() {
			cube([playfield_width + cabinet_thickness * 2, inner_length + cabinet_thickness * 2, slope_height + space_bottom + playfield_thickness + space_top_back]);
			translate([cabinet_thickness, cabinet_thickness, -0.1]) {
				cube([playfield_width, inner_length, slope_height + space_bottom + playfield_thickness + space_top_back + 0.2]);
			}
			translate([-0.1, 0, space_bottom + space_top + playfield_thickness]) {
				slope_top = asin((slope_height + space_top_back - space_top) / (playfield_height + ball_slit + cabinet_thickness * 2));
				rotate([slope_top, 0, 0]) {
					cube([playfield_width + cabinet_thickness * 2 + 0.2, playfield_height * 2, space_top + slope_height]);
					translate([0, 0, -cabinet_plank_width * 3]) {
						cube([playfield_width + cabinet_thickness * 2 + 0.2, playfield_height * 2, cabinet_plank_width]);
					}
				}
			}
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