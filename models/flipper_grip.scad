include <physical_dimensions.scad>;
use <flipper_solenoid.scad>;

//Preference settings.
grip_length = 60;
radius = flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position;
flipper_rotation_angle = 45; //Degrees rotation when activated.
spring_arm = 60; //How far the spring must be from the centre of rotation.
spring_min_thickness = 5; //How thick to make the handles above and below the spring.

//Calculations.
solenoid_arm = flipper_solenoid_pin_expansion / 2 / sin(flipper_rotation_angle / 2);
around_pin = flipper_solenoid_height / 2 - flipper_solenoid_pin_radius;

if(version_num() >= 20181007) { //Assertions was merged on 2018-10-7.
	assert(m3_nut_height < around_pin); //Otherwise there is no space to adhere nut.
	assert(radius <= flipper_solenoid_pin_retracted - flipper_solenoid_pinhole_position); //Otherwise the solenoid intersects with the side of the grip.
}

module attachment(arm, min_thickness, spacing) {
	difference() {
		arm_height = min_thickness * 2 + spacing + tan(90 - printing_overhang) * radius * 2;
		union() { //Body of arm.
			translate([arm, 0, 0]) {
				cylinder(r=radius, h=arm_height);
			}
			translate([0, -radius, 0]) {
				cube([arm, radius * 2, arm_height]);
			}
		}
		translate([arm - radius, -radius, min_thickness]) { //Gap to fit the attachment.
			cube([radius * 2, radius * 2, spacing]);
			diagonal = radius * 2 / cos(printing_overhang);
			translate([0, 0, spacing]) {
				intersection() { //Making this end printable.
					rotate([0, printing_overhang, 0]) {
						cube([radius * 2 / cos(printing_overhang), radius * 2, arm_height]);
					}
					cube([radius * 2, radius * 2, arm_height]);
				}
			}
		}
		cylinder($fn=6, r=hexkey_radius + printing_play, h=arm_height); //Overlap with main hex key.
		translate([arm, 0, 0]) {
			cylinder(r=m3_bolt_radius + printing_play, h=arm_height); //Putting a bolt here to attach it.
			cylinder($fn=6, r=m3_nut_radius + printing_play, h=m3_nut_height); //Leave space for nut.
		}
	}
}

module flipper_grip() {
	solenoid_min_thickness = flipper_solenoid_height / 2 - flipper_solenoid_pingap_thickness / 2;
	difference() {
		union() {
			cylinder(r=radius, h=grip_length); //Main body.
			attachment(solenoid_arm, solenoid_min_thickness, flipper_solenoid_pingap_thickness);
			rotate([0, 0, 180]) {
				attachment(spring_arm, spring_min_thickness, spring_end_thickness);
			}
		}
		cylinder($fn=6, r=hexkey_radius + printing_play, h=grip_length); //Slot for hex key.
		translate([solenoid_arm, 0, solenoid_min_thickness]) {
			rotate([0, 0, flipper_rotation_angle]) {
				translate([-radius, -radius, 0]) {
					cube([radius * 2, 9999999999999, flipper_solenoid_pingap_thickness]);
				}
			}
		}
	}
}

//Debug.
flipper_grip();