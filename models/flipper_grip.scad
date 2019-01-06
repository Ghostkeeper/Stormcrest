include <physical_dimensions.scad>;

//Preference settings.
grip_length = 60;
radius = 10;
flipper_rotation_angle = 45; //Degrees rotation when activated.
spring_arm = 60; //How far the spring must be from the centre of rotation.

//Calculations.
solenoid_arm = flipper_solenoid_pin_expansion / tan(flipper_rotation_angle); //How far the pin needs to be from the rotation axis.
nut_sink = m3_nut_radius / solenoid_arm * (grip_length - flipper_solenoid_height);

module flipper_grip() {
	difference() {
		hull() { //Main body.
			cylinder(r=radius, h=grip_length);
			translate([solenoid_arm, 0, 0]) {
				cylinder(r=radius, h=flipper_solenoid_height);
			}
		}
		cylinder($fn=6, r=hexkey_radius + play, h=grip_length); //Slot for hex key.
		translate([solenoid_arm, 0, flipper_solenoid_height / 2]) { //Slot for solenoid pin (including rotation)
			rotate([-90, 0, 0]) {
				for(a = [0 : $fa : flipper_rotation_angle]) {
					rotate([0, -a, 0]) {
						translate([0, 0, -flipper_solenoid_pinhole_position - play]) {
							cylinder(r=flipper_solenoid_pin_radius + play + movement_play, h=flipper_solenoid_pin_retracted + play);
						}
					}
				}
			}
		}
		translate([solenoid_arm, 0, 0]) { //Slot for bolt through pinhole.
			cylinder(r=flipper_solenoid_pinhole_radius + play, h=grip_length);
			translate([0, 0, grip_length - nut_sink]) { //Slot for nut on bolt.
				cylinder($fn=6, r=m3_nut_radius + play, h=nut_sink);
			}
		}
	}

	around_pin = flipper_solenoid_height / 2 - flipper_solenoid_pin_radius;
	difference() {
		union() {
			translate([-spring_arm, 0, 0]) {
				cylinder(r=radius, h=flipper_solenoid_height);
			}
			translate([-spring_arm, -radius, 0]) {
				cube([spring_arm, radius * 2, flipper_solenoid_height]);
			}
		}
		translate([-spring_arm - radius, -radius, around_pin]) {
			cube([radius * 2, radius * 2, flipper_solenoid_pin_radius * 2]);
		}
		cylinder($fn=6, r=hexkey_radius, h=flipper_solenoid_height);
	}
}

module solenoid() {
	cube([flipper_solenoid_width, flipper_solenoid_length, flipper_solenoid_height]);
	translate([flipper_solenoid_width / 2, 0, flipper_solenoid_height / 2]) {
		difference() {
			rotate([90, 0, 0]) {
				cylinder(r=flipper_solenoid_pin_radius, h=flipper_solenoid_pin_retracted);
			}
			translate([0, flipper_solenoid_pinhole_position - flipper_solenoid_pin_retracted, -flipper_solenoid_pin_radius]) {
				cylinder(r=flipper_solenoid_pinhole_radius, h=flipper_solenoid_pin_radius * 2);
			}
		}
	}
}

//Debug.
flipper_grip();
color([1, 0, 0]) {
	translate([solenoid_arm - flipper_solenoid_width / 2, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position, 0]) {
		//solenoid();
	}
}