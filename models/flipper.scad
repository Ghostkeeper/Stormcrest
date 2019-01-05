//Physically bound settings.
hexkey_radius = 6; //Size 12 hex key.
hexkey_end_length = 30; //TODO.
ball_radius = 15; //Standard pinball size.
play = 0.2; //Horizontal play in printing process.

//Preference settings.
length = 70; //Distance between rotation point and tip of flipper.
big_radius = 15;
small_radius = 7.5;
height = 25;

//Enable once supporting OpenSCAD with asserts (currently only Nightly).
//assert(length - small_radius > hexkey_end_length); //Key would protrude at the small end.
//assert(height > ball_radius + hexkey_radius); //Key would protrude at the top side.
//assert(small_radius > hexkey_radius); //Key would protrude at the sides.
//assert(big_radius > hexkey_radius);
//assert(big_radius > small_radius); //Would be lopsided.

module flipper() {
	difference() {
		hull() {
			cylinder(r=big_radius, h=height);
			translate([length - small_radius, 0, 0]) {
				cylinder(r=small_radius, h=height);
			}
		}
		//Make sure strongest part is at ball height.
		cylinder($fn=6, r=hexkey_radius + play, h=ball_radius);
		translate([0, 0, ball_radius]) {
			rotate([0, 90, 0]) {
				cylinder($fn=6, r=hexkey_radius + play, h=hexkey_end_length);
			}
		}
		intersection() {
			cylinder($fn=6, r=hexkey_radius + play, h=ball_radius + hexkey_radius + play);
			translate([-hexkey_radius - play, 0, ball_radius]) {
				rotate([0, 90, 0]) {
					cylinder($fn=6, r=hexkey_radius + play, h=hexkey_end_length + hexkey_radius + play);
				}
			}
		}

		inscribed_radius = sqrt(3) * (hexkey_radius + play) / 2; //Formula for inscribed radius of hexagon.
		translate([0, -inscribed_radius, 0]) {
			cube([hexkey_end_length, inscribed_radius * 2, ball_radius]);
		}
	}
}

//Debug.
flipper();