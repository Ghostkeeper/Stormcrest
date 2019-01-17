include <physical_dimensions.scad>

//Preferences.
playfield_width = 650;
playfield_height = 1100;
playfield_slope = 6; //Degrees.
space_bottom = 100;
space_top = 200;

difference() {
	cube([playfield_width + cabinet_thickness * 2, cos(playfield_slope) * playfield_height + cabinet_thickness * 2, sin(playfield_slope) * playfield_height + space_bottom + playfield_thickness + space_top]);
	translate([cabinet_thickness, cabinet_thickness, 0]) {
		cube([playfield_width, cos(playfield_slope) * playfield_height, sin(playfield_slope) * playfield_height + space_bottom + playfield_thickness + space_top]);
	}
	translate([0, 0, space_bottom + space_top + playfield_thickness]) {
		rotate([playfield_slope, 0, 0]) {
			cube([playfield_width + cabinet_thickness * 2, playfield_height * 2, space_top + sin(playfield_slope) * playfield_height]);
		}
	}
}
translate([cabinet_thickness, cabinet_thickness, space_bottom]) {
	rotate([playfield_slope, 0, 0]) {
		translate([0, 0, -playfield_thickness]) {
			cube([playfield_width, playfield_height, playfield_thickness]);
		}
	}
}