//Physically bound settings.
printing_play = 0.2; //Horizontal error in 3D printing.
printing_overhang = 50; //Maximum overhang angle. 90 is perfect bridging. 0 is no overhang possible.
movement_play = 0.2; //Play to leave if stuff has to move past each other.

m3_bolt_radius = 1.5;
m3_nut_radius = 5.5 / 2;
m3_nut_height = 2.4;

ball_radius = 15; //Standard pinball size (7/6 inch).
ball_slit = ball_radius * 2 + movement_play * 2 + 4; //Allow 4mm extra space to make the ball fall through faster.

cabinet_thickness = 10; //1cm wooden planks.

flipper_solenoid_width = 13;
flipper_solenoid_height = 15;
flipper_solenoid_length = 30;
flipper_solenoid_pin_radius = 2;
flipper_solenoid_pin_retracted = 8.5; //Length when retracted.
flipper_solenoid_pin_expansion = 10; //Additional length when expanded.
flipper_solenoid_pinhole_position = 2.5; //Distance from centre of hole to tip of pin.
flipper_solenoid_pinhole_radius = m3_bolt_radius;
flipper_solenoid_pingap_thickness = 1.6;
flipper_solenoid_pingap_depth = 7;
flipper_solenoid_screw_radius = m3_bolt_radius;
flipper_solenoid_screw1_position = 8; //Distance from front.
flipper_solenoid_screw2_position = 15 + flipper_solenoid_screw1_position;
flipper_solenoid_screw_depth = 4; //Unknown.

hexkey_radius = 2; //Radius of circumscribed circle around hex key.
hexkey_short_length = 30; //Length of short end.//TODO: How long is this?
hexkey_long_length = 100; //TODO: How long is this?
hexkey_turn_radius = 10; //TODO: Also unknown.

matrix_size = [320, 160]; //Size of LED matrix.

playfield_width = 610;
playfield_height = 1220;
playfield_slope = 6; //Degrees.
playfield_thickness = 10; //TODO: Haven't chosen a playfield yet.

space_bottom = 100;
space_top = 200;

spring_end_thickness = 2; //How thick the attachment part of the spring is.
spring_radius = 4; //Radius of the coil of the spring.