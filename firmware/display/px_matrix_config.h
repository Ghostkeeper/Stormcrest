//Any copyright is dedicated to the public domain. See LICENSE.md for more details.

/*
 * Imports PxMatrix and sets up the defines properly for the pixel matrix we're
 * using.
 *
 * This header produces two globals:
 * * ``display``: The display to draw stuff on. This is PxMatrix's display
 *   struct, which is Adafruit GFX compatible, so it has all the usual drawing
 *   functions.
 * * ``start_display``: A function to be called in the set-up when the display
 *   is ready to start updating.
 */

#include <PxMatrix.h> //Library to draw on a pixel matrix.
#include <Ticker.h> //To set up an interrupt routine to update at a certain frame rate.

#define PIN_LATCH 16
#define PIN_A 5
#define PIN_B 4
#define PIN_C 15
#define PIN_D 12
#define PIN_EARTH 0
#define PIN_OE 2
#define SCANRATE 16

/*
 * The display itself.
 *
 * Send commands to this display in order to update what's being shown on the
 * pixel matrix. It will be shown in the next frame. The updating of the frame
 * will be done asynchronously with an interrupt signal.
 */
PxMATRIX display(64, 32, PIN_LATCH, PIN_OE, PIN_A, PIN_B, PIN_C, PIN_D, PIN_EARTH);

/*
 * An interrupt ticker which will call the update function every so often.
 *
 * The ``_display_updater`` function gets attached to this ticker, which updates
 * the display. The function is never detached. The display cannot be stopped
 * while the machine is running.
 */
Ticker _display_ticker;

/*
 * Updates the display.
 */
void _display_updater() {
	display.display(20);
}

/*
 * Starts the display. From this moment, the LEDs will start updating.
 */
void start_display() {
	display.begin(SCANRATE);
	_display_ticker.attach(0.001, _display_updater);
}
