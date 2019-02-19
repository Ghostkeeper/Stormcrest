//Any copyright is dedicated to the public domain. See LICENSE.md for more details.

/*
 * A screen that displays the current score and number of lives.
 *
 * The screen shows the score in a big text in the middle, the number of balls
 * left using icons in the top left, and a 3D effect of waves in the bottom, as
 * if you're sailing over the open ocean.
 */

#include "waves.h"

#define _NUM_WAVES 32
uint16_t wave_colour = display.color565(0, 0, 255);

class ScreenScore {
public:
	ScreenScore() {
		randomSeed(42); //Doesn't matter that each run is the same, as long as it looks random.
		for(uint8_t i = 0; i < _NUM_WAVES; i++) {
			waves_destination_x[i] = -63 + (126 * i / _NUM_WAVES) + random(-1, 1); //Spread out evenly but with slight jitter.
			waves_y[i] = (20 * i) & 0xF + 16; //Distribute using the golden ratio (32 / phi ~= 20) between 16 and 32.
		}
	}

	void draw() {
		display.fillScreen(0);
		for(uint8_t i = 0; i < _NUM_WAVES; i++) {
			uint8_t size = 3 - (waves_y[i] - 16) / 4; //Which size sprite to use.
			int8_t x_offset; //Some sprites are wider than others
			switch(size) {
				case 0: x_offset = -4; break; //Largest sprite is 8 pixels wide.
				case 1: x_offset = -3; break; //Second-largest sprite is 6 pixels wide.
				default: x_offset = -2; break; //Second-smallest and smallest sprites are 4 pixels wide.
			}
			int8_t x = 32 + waves_destination_x[i] * waves_y[i] / 32;
			int8_t sprite_index = random(8);
			for(uint8_t colour = 0; colour < 7; colour++) {
				switch(size) {
					case 0:
						display.drawBitmap(x, waves_y[i], sprite_waves_0[sprite_index][colour], 8, 4, wave_colour);
						break;
					case 1:
						display.drawBitmap(x, waves_y[i], sprite_waves_1[sprite_index][colour], 6, 3, wave_colour);
						break;
					case 2:
						display.drawBitmap(x, waves_y[i], sprite_waves_2[sprite_index][colour], 4, 2, wave_colour);
						break;
					case 3:
						display.drawBitmap(x, waves_y[i], sprite_waves_3[sprite_index][colour], 4, 1, wave_colour);
						break;
				}
			}
		}
	}

private:
	/*
	 * X position that each wave goes towards, relative to the centre.
	 *
	 * Ranges between -64 and 64.
	 */
	int8_t waves_destination_x[_NUM_WAVES];

	/*
	 * Current Y position of each wave.
	 *
	 * The current X position is then interpolated between 32 and its
	 * destination_x.
	 * Ranges between 16 and 32, the bottom half of the screen.
	 */
	uint8_t waves_y[_NUM_WAVES];
};