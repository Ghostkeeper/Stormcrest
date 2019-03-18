//Protractor with pre-made grooves at certain angles that we need to measure often.

//Settings.
marker_angles = [6, 30, 45, 90];
radius = 100;
groove = 1.05;
thickness = 9;
width = 15;
groove_depth = 2;
printing_play = 0.2;
font_size = 9;
axle_radius = 5;
bar_length = sqrt(200 * 200 + 200 * 200); //Maximum size we're able to print.
clamp_radius = 3;
clamp_thickness = 2;

module protractor_base() {
	difference() {
		//Main body.
		intersection() {
			translate([width / 2, width / 2, 0]) {
				cylinder(r=radius, h=thickness);
			}
			cube(radius + width);
		}
		intersection() {
			translate([width / 2, width / 2, -0.1]) {
				cylinder(r=radius - width, h=thickness + 0.2);
			}
			translate([width, width, -0.1]) {
				cube(radius + width);
			}
		}

		//Letter engravings.
		translate([width / 2, width / 2, thickness - groove_depth]) {
			for(a = marker_angles) {
				rotate([0, 0, a]) {
					translate([radius - width / 2, 0, 0]) {
						linear_extrude(groove_depth + 0.1) {
							text(str(a), halign="center", valign="center", size=font_size);
						}
					}
					translate([0, 0, groove_depth]) {
						cube([radius * 2 - width, groove + printing_play, groove_depth], center=true);
					}
				}
			}
		}

		//Axle to rotate ruler around.
		translate([width / 2, width / 2, -0.1]) {
			cylinder(r=axle_radius + printing_play, h=thickness + 0.2);
			cylinder(r=axle_radius + clamp_radius + printing_play, h=clamp_thickness);
		}
	}
}

module protractor_bar() {
	cube([bar_length, width, thickness]);
	translate([0, width / 2 - groove / 2, 0]) {
		cube([bar_length, groove, thickness + groove_depth]);
	}
	translate([radius - width / 2, width / 2, thickness]) {
		cylinder(r=axle_radius, h=(thickness - clamp_thickness) / 2);
	}
}

module protractor_clamp() {
	cylinder(r=axle_radius + clamp_radius, h=clamp_thickness);
	cylinder(r=axle_radius, h=clamp_thickness + (thickness - clamp_thickness) / 2);
}

protractor_base();
translate([0, -width * 2, 0]) {
	protractor_bar();
}
translate([0, -width * 4, 0]) {
	protractor_clamp();
}