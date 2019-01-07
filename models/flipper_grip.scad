include <physical_dimensions.scad>;
use <flipper_solenoid.scad>;

//Preference settings.
grip_length = 60;
radius = flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position;
flipper_rotation_angle = 45; //Degrees rotation when activated.
spring_arm = 60; //How far the spring must be from the centre of rotation.

//Calculations.
solenoid_arm = flipper_solenoid_pin_expansion / tan(flipper_rotation_angle); //How far the pin needs to be from the rotation axis.
around_pin = flipper_solenoid_height / 2 - flipper_solenoid_pin_radius;

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(m3_nut_height < around_pin); //Otherwise there is no space to adhere nut.
	assert(radius <= flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position); //Otherwise the solenoid intersects with the side of the grip.
}

module flipper_grip() {
	difference() {
		rotate([0, 0, -atan($t * flipper_solenoid_pin_expansion / solenoid_arm)]) {
			hull() { //Main body.
				cylinder(r=radius, h=grip_length);
				translate([solenoid_arm, 0, 0]) {
					cylinder(r=radius, h=grip_length);
				}
			}
		}
		cylinder($fn=6, r=hexkey_radius + play, h=grip_length); //Slot for hex key.
		for(expansion = [0 : $fs : flipper_solenoid_pin_expansion]) {
			rotate([0, 0, atan(expansion / solenoid_arm)]) {
				translate([solenoid_arm, 0, 0]) { //Slot for solenoid pin (including rotation)
					translate([0, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position, flipper_solenoid_height / 2]) {
						rotate([90, 0, 0]) {
							cylinder(r=flipper_solenoid_pin_radius + play + movement_play, h=flipper_solenoid_pin_retracted + expansion);
						}
					}
				}
				translate([solenoid_arm, -expansion, 0]) {
					cylinder(r=m3_bolt_radius + play, h=grip_length); //Slot for pin through pinhole of solenoid.
				}
			}
		}
	}

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
		cylinder($fn=6, r=hexkey_radius + play, h=flipper_solenoid_height); //Overlap with main hex key.
		translate([-spring_arm, 0, 0]) {
			cylinder(r=m3_bolt_radius + play, h=flipper_solenoid_height); //Putting a bolt here to attach spring.
			cylinder($fn=6, r=m3_nut_radius + play, h=m3_nut_height); //Leave space for nut.
		}
	}
}

//Debug.
flipper_grip();
color([1, 0, 0]) {
	translate([solenoid_arm, 0, 0]) {
		//flipper_solenoid();
	}
}