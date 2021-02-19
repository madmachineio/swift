#ifndef CHARCATEGORY_H
#define CHARCATEGORY_H

#ifdef __cplusplus
extern "C" {
#endif

typedef enum UCharCategory {
  /*
   * Note: UCharCategory constants and their API comments are parsed by
   * preparseucd.py. It matches pairs of lines like / ** <Unicode 2-letter
   * General_Category value> comment... * / U_<[A-Z_]+> = <integer>,
   */

  U_UNASSIGNED = 0,
  U_GENERAL_OTHER_TYPES = 0,
  U_UPPERCASE_LETTER = 1,
  U_LOWERCASE_LETTER = 2,
  U_TITLECASE_LETTER = 3,
  U_MODIFIER_LETTER = 4,
  U_OTHER_LETTER = 5,
  U_NON_SPACING_MARK = 6,
  U_ENCLOSING_MARK = 7,
  U_COMBINING_SPACING_MARK = 8,
  U_DECIMAL_DIGIT_NUMBER = 9,
  U_LETTER_NUMBER = 10,
  U_OTHER_NUMBER = 11,
  U_SPACE_SEPARATOR = 12,
  U_LINE_SEPARATOR = 13,
  U_PARAGRAPH_SEPARATOR = 14,
  U_CONTROL_CHAR = 15,
  U_FORMAT_CHAR = 16,
  U_PRIVATE_USE_CHAR = 17,
  U_SURROGATE = 18,
  U_DASH_PUNCTUATION = 19,
  U_START_PUNCTUATION = 20,
  U_END_PUNCTUATION = 21,
  U_CONNECTOR_PUNCTUATION = 22,
  U_OTHER_PUNCTUATION = 23,
  U_MATH_SYMBOL = 24,
  U_CURRENCY_SYMBOL = 25,
  U_MODIFIER_SYMBOL = 26,
  U_OTHER_SYMBOL = 27,
  U_INITIAL_PUNCTUATION = 28,
  U_FINAL_PUNCTUATION = 29,
  U_CHAR_CATEGORY_COUNT
} UCharCategory;

#ifdef __cplusplus
}
#endif

#endif
