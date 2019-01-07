include <physical_dimensions.scad>;
use <flipper_solenoid.scad>;

//Preference settings.
grip_length = 60;
radius = flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position;
flipper_rotation_angle = 45; //Degrees rotation when activated.
spring_arm = 60; //How far the spring must be from the centre of rotation.
spring_min_thickness = 5; //How thick to make the handles above and below the spring.

//Calculations.
solenoid_arm = flipper_solenoid_pin_expansion / tan(flipper_rotation_angle); //How far the pin needs to be from the rotation axis.
around_pin = flipper_solenoid_height / 2 - flipper_solenoid_pin_radius;

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(m3_nut_height < around_pin); //Otherwise there is no space to adhere nut.
	assert(radius <= flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position); //Otherwise the solenoid intersects with the side of the grip.
}

module flipper_grip() {
	difference() {
		hull() { //Main body.
			cylinder(r=radius, h=grip_length);
			translate([solenoid_arm + flipper_solenoid_pin_expansion, 0, 0]) {
				cylinder(r=radius, h=grip_length);
			}
		}
		cylinder($fn=6, r=hexkey_radius + printing_play, h=grip_length); //Slot for hex key.
		for(expansion = [0 : $fs : flipper_solenoid_pin_expansion]) {
			rotate([0, 0, atan(expansion / solenoid_arm)]) {
				translate([solenoid_arm, 0, 0]) { //Slot for solenoid pin (including rotation)
					translate([0, flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position, flipper_solenoid_height / 2]) {
						rotate([90, 0, 0]) {
							cylinder(r=flipper_solenoid_pin_radius + printing_play + movement_play, h=flipper_solenoid_pin_retracted + expansion);
						}
					}
				}
				translate([solenoid_arm, -expansion, 0]) {
					cylinder(r=m3_bolt_radius + printing_play, h=grip_length); //Slot for pin through pinhole of solenoid.
				}
			}
		}
	}

	difference() { //Spring arm.
		spring_arm_height = spring_min_thickness * 2 + spring_end_thickness + tan(90 - printing_overhang) * radius * 2;
		union() { //Body of arm.
			translate([-spring_arm, 0, 0]) {
				cylinder(r=radius, h=spring_arm_height);
			}
			translate([-spring_arm, -radius, 0]) {
				cube([spring_arm, radius * 2, spring_arm_height]);
			}
		}
		translate([-spring_arm - radius, -radius, spring_min_thickness]) { //Gap to fit end of spring.
			cube([radius * 2, radius * 2, spring_end_thickness]);
			diagonal = radius * 2 / cos(printing_overhang);
			translate([radius * 2, 0, spring_end_thickness]) {
				intersection() { //Making this end printable.
					rotate([0, -90 - printing_overhang, 0]) {
						cube([radius * 2 / cos(printing_overhang), radius * 2, spring_arm_height]);
					}
					translate([-radius * 2, 0, 0]) {
						cube([radius * 2, radius * 2, spring_arm_height]);
					}
				}
			}
		}
		cylinder($fn=6, r=hexkey_radius + printing_play, h=spring_arm_height); //Overlap with main hex key.
		translate([-spring_arm, 0, 0]) {
			cylinder(r=m3_bolt_radius + printing_play, h=spring_arm_height); //Putting a bolt here to attach spring.
			cylinder($fn=6, r=m3_nut_radius + printing_play, h=m3_nut_height); //Leave space for nut.
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