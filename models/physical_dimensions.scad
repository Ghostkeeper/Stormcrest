//Physically bound settings.
printing_play = 0.2; //Horizontal error in 3D printing.
printing_overhang = 50; //Maximum overhang angle. 90 is perfect bridging. 0 is no overhang possible.
printer_height = 300; //Maximum height that we can print. Assuming it is square.
movement_play = 0.2; //Play to leave if stuff has to move past each other.

m3_bolt_radius = 1.5;
m3_bolt_head_radius = 2.5;
m3_nut_radius = 5.5 / 2;
m3_nut_height = 2.4;
m4_bolt_radius = 2;

ball_radius = 15; //Standard pinball size (7/6 inch).
ball_slit = ball_radius * 2 + movement_play * 2 + 4; //Allow 4mm extra space to make the ball fall through faster.
roll_slope = atan2(0.1, 1.5); //About 4 degrees. Minimum slope necessary to make the ball roll with 0.1mm layer height.

cabinet_thickness = 18; //1.8cm wooden planks.
cabinet_plank_width = 196; //Planks are this wide.
cabinet_plank_length = 2690 / 2; //Actually 2690, but saw them in two.

flipper_solenoid_width = 13;
flipper_solenoid_height = 15;
flipper_solenoid_length = 30;
flipper_solenoid_pin_radius = 2;
flipper_solenoid_pin_retracted = 8.5; //Length when retracted.
flipper_solenoid_pin_expansion = 10; //Stroke length.
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

lane_width = 50;
lane_wall_thickness = 0.35 * 6; //6 wall line widths with a 0.4mm 3D printer nozzle.
lane_connector_length = 30; //How much overlap to join multiple lanes together if the printer is too small.
lane_chamfer_radius = 10;

matrix_size = [320, 160]; //Size of LED matrix.

playfield_width = 610;
playfield_height = 1220;
playfield_slope = 6; //Degrees.
playfield_thickness = 18;

plunger_cap_radius = 5; //How far the cap protrudes into the launching lane.
plunger_cap_cone_length = 15;
plunger_gate_alignment_length = 10; //At the front of the gate, how long the alignment ramps are that align the ball in the centre.
plunger_rod_length = 100; //TODO: Buy a rod?
plunger_rod_radius = 2.5;
plunger_handle_overlap = 10; //How far the rod protrudes in the handle.
plunger_handle_radius = 20;
plunger_handle_height = 40;
plunger_spring_length = 50; //How much room we need for the spring.

solenoid_width = 13;
solenoid_height = 15;
solenoid_length = 30;
solenoid_pin_radius = 2;
solenoid_pin_retracted = 8.5; //Length when retracted.
solenoid_pin_expansion = 10; //Stroke length.
solenoid_pinhole_position = 2.5; //Distance from centre of hole to tip of pin.
solenoid_pinhole_radius = m3_bolt_radius;
solenoid_pingap_thickness = 1.6;
solenoid_pingap_depth = 7;
solenoid_screw_radius = m3_bolt_radius;
solenoid_screw1_position = 8; //Distance from front.
solenoid_screw2_position = 15 + solenoid_screw1_position;
solenoid_screw_depth = 4; //Unknown.

space_bottom = 100;
space_top = 100;
space_top_back = 200;

spring_end_thickness = 2; //How thick the attachment part of the spring is.
spring_radius = 4; //Radius of the coil of the spring.