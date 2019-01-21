include <physical_dimensions.scad>

//Preferences.
playfield_width = 610;
playfield_height = 1220;
playfield_slope = 6; //Degrees.
space_bottom = 100;
space_top = 200;
ball_slit = ball_radius * 2 + movement_play * 2 + 4; //Allow 4mm extra space to make the ball fall through faster.

difference() {
	cube([playfield_width + cabinet_thickness * 2, cos(playfield_slope) * (playfield_height + ball_slit) + cabinet_thickness * 2, sin(playfield_slope) * (playfield_height + ball_slit) + space_bottom + playfield_thickness + space_top]);
	translate([cabinet_thickness, cabinet_thickness, 0]) {
		cube([playfield_width, cos(playfield_slope) * (playfield_height + ball_slit), sin(playfield_slope) * (playfield_height + ball_slit) + space_bottom + playfield_thickness + space_top]);
	}
	translate([0, 0, space_bottom + space_top + playfield_thickness]) {
		rotate([playfield_slope, 0, 0]) {
			cube([playfield_width + cabinet_thickness * 2, playfield_height * 2, space_top + sin(playfield_slope) * playfield_height]);
		}
	}
}
translate([cabinet_thickness, cabinet_thickness + ball_slit, space_bottom]) {
	rotate([playfield_slope, 0, 0]) {
		translate([0, 0, -playfield_thickness]) {
			cube([playfield_width, playfield_height, playfield_thickness]);
		}
	}
}