//This is the full assembly of the pinball machine.
include <physical_dimensions.scad>
use <cabinet.scad>
use <flipper.scad>

module playfield() {
	translate([playfield_width / 2 - 100, 100, 0]) {
		rotate([0, 0, 22.5]) { //Flipper turned 22.5 degrees upward, 22.5 degrees downward.
			flipper();
		}
	}
	translate([playfield_width / 2 + 100, 100, 0]) {
		rotate([0, 0, -22.5]) {
			mirror([1, 0, 0]) {
				flipper();
			}
		}
	}
}

cabinet();

translate([0, 0, space_bottom]) {
	rotate([playfield_slope, 0, 0]) {
		translate([0, ball_slit, 0]) {
			playfield();
		}
	}
}