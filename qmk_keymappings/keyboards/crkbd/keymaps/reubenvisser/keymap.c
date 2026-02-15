/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

    COMBO_LENGTH // keep this last
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H

enum combos {
    // LAYER SHIFTS
    NUM,
    I3,
    FN,

    // SYMBOLS
    COMMA,
    DOT,
    COLON,
    SEMICOLON,
    QUOT,
    DQUOT,

    SLASH,
    BSLASH,
    PIPE,
    CIRC,
    PERC,
    GRV,
    TILD,

    EXLM,
    QUES,
    DLR,

    AT,
    AMPR,
    ASTR,
    HASH,

    // BASIC MATHS
    MINUS,
    UNDS,
    EQL,
    PLUS,

    // BRACKETS
    LPRN,
    RPRN,
    LBRC,
    RBRC,
    LCBR,
    RCBR,
    LABK,
    RABK,

    // MISC
    TAB,
    WHLU,
    WHLD,
    WHLL,
    WHLRH
}

const uint16_t PROGMEM num_combo[] = {KC_S, KC_T, COMBO_END};
const uint16_t PROGMEM i3_combo[] = {KC_S, KC_G, COMBO_END};
const uint16_t PROGMEM fn_combo[] = {KC_S, KC_G, KC_LSHIFT, COMBO_END};

const uint16_t PROGMEM comma_combo[] = {KC_H, KC_LEFT, COMBO_END};
const uint16_t PROGMEM dot_combo[] = {KC_LEFT, KC_RIGHT, COMBO_END};
const uint16_t PROGMEM colon_combo[] = {KC_R, KC_S, KC_T, COMBO_END};
const uint16_t PROGMEM semicolon_combo[] = {KC_R, KC_S, KC_G, COMBO_END};
const uint16_t PROGMEM quot_combo[] = {KC_N, KC_U, COMBO_END};
const uint16_t PROGMEM dquot_combo[] = {KC_N, KC_Y, COMBO_END};

const uint16_t PROGMEM slash_combo[] = {KC_X, KC_S, KC_P, COMBO_END};
const uint16_t PROGMEM bslash_combo[] = {KC_W, KC_S, KC_D, COMBO_END};
const uint16_t PROGMEM pipe_combo[] = {KC_P, KC_T, COMBO_END};
const uint16_t PROGMEM circ_combo[] = {KC_R, KC_F, KC_T, COMBO_END};
const uint16_t PROGMEM perc_combo[] = {KC_W, KC_D, COMBO_END};
const uint16_t PROGMEM grv_combo[] = {KC_F, KC_T, COMBO_END};
const uint16_t PROGMEM tild_combo[] = {KC_W, KC_T, COMBO_END};

combo_t key_combos[] = {
    [NUM] = COMBO(num_combo, mod(1)),
    [I3] = COMBO(i3_combo, mod(2)),
    [FN] = COMBO(fn_combo, mod(3)),

    [COMMA] = COMBO(comma_combo, KC_COMMA),
    [DOT] = COMBO(dot_combo, KC_DOT),
    [COLON] = COMBO(colon_combo, KC_COLON),
    [SEMICOLON] = COMBO(semicolon_combo, KC_SIMICOLON),
    [QUOT] = COMBO(quot_combo, KC_QUOT),
    [DQUOT] = COMBO(dquot_combo, KC_DQUOT),

    [SLASH] = COMBO(slash_combo, KC_SLASH),
    [BSLASH] = COMBO(bslash_combo, KC_BSLASH),
    [PIPE] = COMBO(pipe_combo, KC_PIPE),
    [CIRC] = COMBO(circ_combo, KC_CIRC),
    [PECR] = COMBO(perc_combo, KC_PERC),
    [GRV] = COMBO(grv_combo, KC_GRV),
    [TILD] = COMBO(tild_combo, KC_TILD),
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      KC_LALT,    KC_Q,    KC_W,    KC_F,    KC_P,    KC_B,                         KC_J,    KC_L,    KC_U,    KC_Y, XXXXXXX, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LCTL,    KC_A,    KC_R,    KC_S,    KC_T,    KC_G,                         KC_K,    KC_J,    KC_E,    KC_E, KC_I   , KC_O   ,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      KC_LGUI,    KC_Z,    KC_X,    KC_C,    KC_D,    KC_V,                         KC_M,    KC_H, KC_LEFT, KC_DOWN,   KC_UP,KC_RIGHT,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          KC_ESC ,KC_LSHIF,  KC_ENT,     KC_SPC, KC_BSPC, XXXXXXX
                                      //`--------------------------'  `--------------------------'

  ),

};

#ifdef ENCODER_MAP_ENABLE
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {
  [0] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [1] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [2] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
  [3] = { ENCODER_CCW_CW(KC_VOLD, KC_VOLU), ENCODER_CCW_CW(KC_MPRV, KC_MNXT), ENCODER_CCW_CW(RM_VALD, RM_VALU), ENCODER_CCW_CW(KC_RGHT, KC_LEFT), },
};
#endif
