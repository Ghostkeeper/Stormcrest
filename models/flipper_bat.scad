include <physical_dimensions.scad>

//Preference settings.
length = 70; //Distance between rotation point and tip of flipper.
big_radius = 15;
small_radius = 7.5;
height = 25;

//Enable once supporting OpenSCAD with asserts (currently only Nightly).
if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(length - small_radius > hexkey_short_length); //Key would protrude at the small end.
	assert(height > ball_radius + hexkey_radius); //Key would protrude at the top side.
	assert(small_radius > hexkey_radius); //Key would protrude at the sides.
	assert(big_radius > hexkey_radius);
	assert(big_radius > small_radius); //Would be lopsided.
}

module flipper_bat() {
	difference() {
		hull() {
			cylinder(r=big_radius, h=height);
			translate([length - small_radius, 0, 0]) {
				cylinder(r=small_radius, h=height);
			}
		}
		//Make sure strongest part is at ball height.
		cylinder($fn=6, r=hexkey_radius + printing_play, h=ball_radius);
		translate([0, 0, ball_radius]) {
			rotate([0, 90, 0]) {
				cylinder($fn=6, r=hexkey_radius + printing_play, h=hexkey_short_length);
			}
		}
		intersection() {
			cylinder($fn=6, r=hexkey_radius + printing_play, h=ball_radius + hexkey_radius + printing_play);
			translate([-hexkey_radius - printing_play, 0, ball_radius]) {
				rotate([0, 90, 0]) {
					cylinder($fn=6, r=hexkey_radius + printing_play, h=hexkey_short_length + hexkey_radius + printing_play);
				}
			}
		}

		inscribed_radius = sqrt(3) * (hexkey_radius + printing_play) / 2; //Formula for inscribed radius of hexagon.
		translate([0, -inscribed_radius, 0]) {
			cube([hexkey_short_length, inscribed_radius * 2, ball_radius]);
		}
	}
}

//Debug.
flipper_bat();