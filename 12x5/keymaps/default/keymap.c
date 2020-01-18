/* Copyright 2019 Marco Lochen
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include QMK_KEYBOARD_H

// Defines the keycodes used by our macros in process_record_user
enum custom_keycodes { QMKBEST = SAFE_RANGE, QMKURL };

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT(
		KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_MUTE, KC_VOLD, KC_VOLU,
		KC_ESC,  KC_X,    KC_V,    KC_L,    KC_C,    KC_W,    KC_K,    KC_H,    KC_G,    KC_F,    KC_Q,    KC_BSPC,
		KC_TAB,  KC_U,    KC_I,    KC_A,    KC_E,    KC_O,    KC_S,    KC_N,    KC_R,    KC_T,    KC_D,    KC_ENT,
		KC_LCTL, KC_LBRC, KC_SCLN, KC_QUOT, KC_P,    KC_Y,    KC_B,    KC_M,    KC_COMM, KC_DOT,  KC_J,    KC_Z,
		KC_LCTL, KC_LGUI, KC_LALT, KC_LGUI, KC_LSFT, MO(2),   MO(1),   KC_SPC,  KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT),

	[1] = LAYOUT(
		_______, _______,       _______,       _______,       _______,       _______,       _______,       _______,    _______,       _______,       _______,       _______,
		_______, LSFT(KC_GRV),  LSFT(KC_SLSH), RALT(KC_8),    RALT(KC_9),    KC_GRV,        LSFT(KC_1),    KC_NUBS,    LSFT(KC_NUBS), LSFT(KC_0),    LSFT(KC_6),    _______,
		_______, RALT(KC_MINS), LSFT(KC_7),    RALT(KC_7),    RALT(KC_0),    LSFT(KC_RBRC), LSFT(KC_MINS), LSFT(KC_8), LSFT(KC_9),    KC_SLSH,       LSFT(KC_DOT),  _______,
		_______, KC_NUHS,       LSFT(KC_4),    RALT(KC_NUBS), RALT(KC_RBRC), LSFT(KC_EQL),  KC_RBRC,       LSFT(KC_5), LSFT(KC_2),    LSFT(KC_NUHS), LSFT(KC_COMM), RALT(KC_Q),
		_______, _______,       _______,       _______,       _______,       _______,       _______,       _______,     _______,      _______,       _______,       _______),

	[2] = LAYOUT(
		_______, _______, _______, _______, _______, _______, _______, _______, _______, KC_F10,  KC_F11,  KC_F12,
		_______, KC_PGUP, KC_BSPC, KC_UP,   KC_DEL,  KC_PGDN, _______, KC_7,    KC_8,    KC_9,    _______, _______,
		_______, KC_HOME, KC_LEFT, KC_DOWN, KC_RGHT, KC_END,  KC_MINS, KC_4,    KC_5,    KC_6,    KC_DOT,  _______,
		_______, _______, _______, _______,  KC_INS, _______, _______, KC_1,    KC_2,    KC_3,    KC_COMM, _______,
		_______, _______, _______, _______, _______, _______, _______, KC_0,    KC_HOME, KC_PGDN, KC_PGUP, KC_END ),
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case QMKBEST:
            if (record->event.pressed) {
                // when keycode QMKBEST is pressed
                SEND_STRING("QMK is the best thing ever!");
            } else {
                // when keycode QMKBEST is released
            }
            break;
        case QMKURL:
            if (record->event.pressed) {
                // when keycode QMKURL is pressed
                SEND_STRING("https://qmk.fm/" SS_TAP(X_ENTER));
            } else {
                // when keycode QMKURL is released
            }
            break;
    }
    return true;
}

void matrix_init_user(void) {}

void matrix_scan_user(void) {}

void led_set_user(uint8_t usb_led) {}
