include <physical_dimensions.scad>
include <global_preferences.scad>

//Preferences.
wire_radius = 0.8;
length = 80;
twists = 30;

module spring() {
	color(color_hardware) {
		linear_extrude(height=length, twist=twists * 360) {
			translate([spring_radius - wire_radius, 0, 0]) {
				circle(r=wire_radius);
			}
		}
		translate([0, spring_end_thickness / 2, 0]) {
			rotate([90, 0, 0]) {
				cylinder(r=spring_radius, h=spring_end_thickness);
				translate([0, length, 0]) {
					cylinder(r=spring_radius, h=spring_end_thickness);
				}
			}
		}
	}
}

spring();