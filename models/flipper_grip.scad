//Physically bound settings.
hexkey_radius = 6;
solenoid_pin_radius = 3;
solenoid_width = 16;
solenoid_height = 15;
solenoid_length = 30;
solenoid_pin_retracted = 25;
solenoid_pin_expansion = 10;
solenoid_pinhole_position = 3; //Distance from centre of hole to tip of pin.
solenoid_pinhole_radius = 1.5;

//Preference settings.
grip_length = 60;
radius = 10;
flipper_rotation_angle = 45; //Degrees rotation when activated.
$fa = 1;

//Calculations.
solenoid_arm = solenoid_pin_expansion / tan(flipper_rotation_angle);

module flipper_grip() {
	difference() {
		hull() {
			cylinder(r=radius, h=grip_length);
			translate([solenoid_arm, 0, 0]) {
				cylinder(r=radius, h=solenoid_height);
			}
		}
		cylinder($fn=6, r=hexkey_radius, h=grip_length);
		translate([solenoid_arm, -solenoid_pinhole_position, solenoid_height / 2]) {
			rotate([-90, 0, 0]) {
				for(a = [0 : $fa : flipper_rotation_angle]) {
					rotate([0, -a, 0]) {
						cylinder(r=solenoid_pin_radius, h=solenoid_pin_retracted);
					}
				}
			}
		}
		translate([solenoid_arm, 0, 0]) {
			cylinder(r=solenoid_pinhole_radius, h=grip_length);
		}
	}
}

module solenoid() {
	cube([solenoid_width, solenoid_length, solenoid_height]);
	translate([solenoid_width / 2, 0, solenoid_height / 2]) {
		difference() {
			rotate([90, 0, 0]) {
				cylinder(r=solenoid_pin_radius, h=solenoid_pin_retracted);
			}
			translate([0, solenoid_pinhole_position - solenoid_pin_retracted, -solenoid_pin_radius]) {
				cylinder(r=solenoid_pinhole_radius, h=solenoid_pin_radius * 2);
			}
		}
	}
}

//Debug.
flipper_grip();
color([1, 0, 0]) {
	translate([solenoid_arm - solenoid_width / 2, solenoid_pin_retracted - solenoid_pinhole_position, 0]) {
		//solenoid();
	}
}