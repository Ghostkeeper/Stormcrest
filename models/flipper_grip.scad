//Physically bound settings.
hexkey_radius = 6;

//Preference settings.
grip_length = 60;
radius = 20;

module flipper_grip() {
	difference() {
		cylinder(r=radius, h=grip_length);
		cylinder($fn=6, r=hexkey_radius, h=grip_length);
	}
}

//Debug.
flipper_grip();