//Any copyright is dedicated to the public domain. See LICENSE.md for more details.

/*
 * Firmware to control the LED matrix display of the Stormcrest pinball machine.
 *
 * This firmware is designed to run on a Lolin (Wemos) D1.
 *
 * This program communicates to the main game computer via a serial connection.
 * The main game computer tells the display computer what to show. To this end,
 * a small protocol is used where the main game computer can command this
 * display firmware to:
 * - Set the default screen to show.
 * - Temporarily show a different screen. After a set period of time, the
 *   display will revert to the default screen.
 * - Change an internal variable in the screen. This is used, for instance, to
 *   update the score, the number of balls, the currently selected menu item,
 *   etc.
 *
 * After every received command, the device communicates back via the serial
 * connection to acknowledge the command.
 *
 * The available screens are hard-coded in this display firmware as structs.
 * They will each have an update() method that draws the screen.
 */

#include "px_matrix_config.h"
#include "screen_score.h"

ScreenScore screen_score;

void setup() {
	start_display();
}

void loop() {
	screen_score.draw();
}
