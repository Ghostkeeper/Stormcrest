//This is the full assembly of the pinball machine.
include <physical_dimensions.scad>
use <cabinet.scad>
use <flipper.scad>
use <plunger.scad>

module playfield() {
	//Flippers.
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

	//Plunger.
	translate([playfield_width - lane_width / 2, -ball_slit, 0]) {
		plunger();
	}
}

cabinet();

translate([cabinet_thickness, cabinet_thickness + ball_slit, space_bottom]) {
	rotate([playfield_slope, 0, 0]) {
		playfield();
	}
}