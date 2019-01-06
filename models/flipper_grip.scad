//Physically bound settings.
hexkey_radius = 6;
solenoid_pin_radius = 3;
solenoid_width = 16;
solenoid_height = 15;
solenoid_length = 30;
solenoid_pin_retracted = 15;
solenoid_pin_expansion = 10;

//Preference settings.
grip_length = 60;
radius = 10;
flipper_rotation_angle = 50; //Degrees rotation when activated.

//Calculations.
solenoid_arm = solenoid_pin_expansion / tan(flipper_rotation_angle);
echo(solenoid_arm);

module flipper_grip() {
	difference() {
		cylinder(r=radius, h=grip_length);
		cylinder($fn=6, r=hexkey_radius, h=grip_length);
	}
}

module solenoid() {
	cube([solenoid_width, solenoid_length, solenoid_height]);
	translate([solenoid_width / 2, 0, solenoid_height / 2]) {
		rotate([90, 0, 0]) {
			cylinder(r=solenoid_pin_radius, h=solenoid_pin_retracted);
		}
	}
}

//Debug.
flipper_grip();
color([1, 0, 0]) {
	translate([solenoid_arm, solenoid_pin_retracted, 0]) {
		solenoid();
	}
}