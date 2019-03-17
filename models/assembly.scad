//This is the full assembly of the pinball machine.
include <physical_dimensions.scad>
use <cabinet.scad>
use <flipper.scad>
use <gutter_lift.scad>
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
	translate([playfield_width - lane_width / 2, -ball_slit - cabinet_thickness - plunger_handle_overlap + plunger_rod_length, 0]) {
		rotate([-playfield_slope, 0, 0]) {
			plunger();
		}
	}

	//Gutter and lift.
	translate([playfield_width - lane_width - lane_wall_thickness * 2 - ball_slit - printing_play, -ball_slit - lane_wall_thickness * 2, -ball_radius * 2 - lane_wall_thickness - printing_play - movement_play - sin(roll_slope) * printer_height - playfield_thickness]) {
		gutter_lift();
	}
}

cabinet();

translate([cabinet_thickness, cabinet_thickness + ball_slit, space_bottom]) {
	rotate([playfield_slope, 0, 0]) {
		playfield();
	}
}