include <physical_dimensions.scad>

module hexkey() {
	cylinder($fn=6, r=hexkey_radius, h=hexkey_long_length - hexkey_turn_radius);
	translate([hexkey_turn_radius, 0, hexkey_long_length - hexkey_turn_radius]) {
		intersection() {
			rotate([90, 0, 0]) {
				rotate_extrude() {
					translate([-hexkey_turn_radius, 0, 0]) {
						circle($fn=6, r=hexkey_radius);
					}
				}
			}
			translate([-hexkey_turn_radius - hexkey_radius, -hexkey_radius, 0]) {
				cube(hexkey_turn_radius + hexkey_radius);
			}
		}
	}
	translate([hexkey_turn_radius, 0, hexkey_long_length]) {
		rotate([0, 90, 0]) {
			cylinder($fn=6, r=hexkey_radius, h=hexkey_short_length - hexkey_turn_radius);
		}
	}
}

//Debug.
hexkey();