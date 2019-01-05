//Physically bound settings.
hexkey_radius = 3;

//Preference settings.
length = 100; //Distance between rotation point and tip of flipper.
big_radius = 20;
small_radius = 7.5;
height = 30;

module body() {
	hull() {
		cylinder(r=big_radius, h=height);
		translate([length - small_radius, 0, 0]) {
			cylinder(r=small_radius, h=height);
		}
	}
}

//Debug.
body();