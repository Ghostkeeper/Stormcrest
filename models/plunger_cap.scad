//Cap on top of the plunger rod.
//This has 4 functions:
//* Dampen the force on the ball to not scratch or dent it.
//* Transfer force from the spring towards the rod.
//* Stop the plunger from shooting along the launching lane.
//* Align the plunger towards the centre.

include <physical_dimensions.scad>

module plunger_cap() {
	plunger_cap_shaft_length = plunger_rod_length - cabinet_thickness - plunger_handle_overlap - plunger_spring_length - plunger_cap_cone_length;

	difference() {
		union() {
			sphere(r=plunger_cap_radius);
			rotate([90, 0, 0]) {
				cylinder(r1=plunger_cap_radius, r2=ball_radius, h=plunger_cap_cone_length);
			}
			translate([0, -plunger_cap_cone_length, 0]) {
				rotate([90, 0, 0]) {
					cylinder(r=ball_radius, h=plunger_cap_shaft_length);
				}
			}
		}
		rotate([90, 0, 0]) {
			cylinder(r=plunger_rod_radius, h=plunger_cap_cone_length + plunger_cap_shaft_length);
		}
	}
}

plunger_cap();