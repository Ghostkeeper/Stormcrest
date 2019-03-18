//Protractor with pre-made grooves at certain angles that we need to measure often.

//Settings.
marker_angles = [6, 30, 45, 90];
radius = 100;
groove = 1.05;
thickness = 5;
width = 15;
groove_depth = 2;
printing_play = 0.2;
font_size = 9;
axle_radius = 5;

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
		}
	}
}

protractor_base();