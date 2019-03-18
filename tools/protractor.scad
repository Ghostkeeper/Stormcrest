//Protractor with pre-made grooves at certain angles that we need to measure often.

//Settings.
marker_angles = [6, 30, 45, 90];
radius = 100;
groove = 1.05;
thickness = 5;
width = 15;
groove_depth = 2;
printing_play = 0.2;

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
			translate([width / 2, width / 2, 0]) {
				cylinder(r=radius - width, h=thickness);
			}
			translate([width, width, 0]) {
				cube(radius + width);
			}
		}
	}
}

protractor_base();