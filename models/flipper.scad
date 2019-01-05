//Physically bound settings.
hexkey_radius = 6; //Size 12 hex key.
hexkey_end_length = 30; //TODO.
ball_radius = 15; //Standard pinball size.

//Preference settings.
length = 70; //Distance between rotation point and tip of flipper.
big_radius = 15;
small_radius = 7.5;
height = 30;

module flipper() {
	difference() {
		hull() {
			cylinder(r=big_radius, h=height);
			translate([length - small_radius, 0, 0]) {
				cylinder(r=small_radius, h=height);
			}
		}
		//Make sure strongest part is at ball height.
		cylinder($fn=6, r=hexkey_radius, h=ball_radius + hexkey_radius);
		translate([0, 0, ball_radius]) {
			rotate([0, 90, 0]) {
				cylinder($fn=6, r=hexkey_radius, h=hexkey_end_length);
			}
		}
		inscribed_radius = sqrt(3) * hexkey_radius / 2; //Formula for inscribed radius of hexagon.
		translate([0, -inscribed_radius, 0]) {
			cube([hexkey_end_length, inscribed_radius * 2, ball_radius]);
		}
	}
}

//Debug.
flipper();