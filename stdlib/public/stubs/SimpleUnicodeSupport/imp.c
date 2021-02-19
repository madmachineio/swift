#include "stdlib_interface.h"
#include "unicode.h"
#include <assert.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>

UText *utext_openUTF8(UText *ut, const char *s, int64_t length,
                      UErrorCode *status) {
  if (!ut)
    ut = (UText *)malloc(sizeof(UText));
  ut->type = UTEXT_UTF8;
  ut->length = length;
  ut->code_points.utf8 = s;
  return ut;
}

UText *utext_openUChars(UText *ut, const UChar *s, int64_t length,
                        UErrorCode *status) {
  if (!ut)
    ut = (UText *)malloc(sizeof(UText));
  ut->type = UTEXT_UTF16;
  ut->length = length;
  ut->code_points.utf16 = s;
  *status = U_ZERO_ERROR;
  return ut;
}

UBreakIterator *ubrk_open(UBreakIteratorType type, const char *locale,
                          const UChar *text, int32_t textLength,
                          UErrorCode *status) {
  if (text != NULL)
    abort(); // not used by the stdlib
  UBreakIterator *it = (UBreakIterator *)malloc(sizeof(UBreakIterator));
  it->type = type;
  it->text = NULL;
  *status = U_ZERO_ERROR;
  return it;
}

void ubrk_setText(UBreakIterator *it, const UChar *text, int32_t length,
                  UErrorCode *status) {
  abort(); // not used by the swift std library
}

void ubrk_setUText(UBreakIterator *it, UText *text, UErrorCode *status) {
  it->text = text;
  *status = U_ZERO_ERROR;
}

void ubrk_close(UBreakIterator *it) {
  if (it)
    free(it);
}

int32_t ubrk_preceding(UBreakIterator *it, int32_t offset) {
  if (it->type == UTEXT_UTF8) {
    offset--;
    while (true) {
      if (offset <= 0)
        return UBRK_DONE;
      else if (!UTF8_IS_CONT(it->text->code_points.utf8[offset]))
        return offset;
      else
        offset--;
    }
  } else if (it->type == UTEXT_UTF16) {
    abort();
  } else {
    abort();
  }
}

int32_t ubrk_following(UBreakIterator *it, int32_t offset) {
  if (it->type == UTEXT_UTF8) {
    offset++;
    while (true) {
      if (offset >= it->text->length)
        return UBRK_DONE;
      else if (!UTF8_IS_CONT(it->text->code_points.utf8[offset]))
        return offset;
      else
        offset++;
    }
  } else if (it->type == UTEXT_UTF16) {
    abort();
  } else {
    abort();
  }
}

int32_t unorm2_spanQuickCheckYes(const UNormalizer2 *norm2, const UChar *s,
                                 int32_t length, UErrorCode *status) {
  *status = U_ZERO_ERROR;
  return length;
}

int32_t unorm2_normalize(const UNormalizer2 *norm2, const UChar *src,
                         int32_t length, UChar *dest, int32_t capacity,
                         UErrorCode *pErrorCode) {
  if (capacity < length) {
    *pErrorCode = U_SOME_ERROR;
    return 0;
  }
  memcpy(dest, src, sizeof(UChar) * length);
  *pErrorCode = U_ZERO_ERROR;
  return length;
}

const UNormalizer2 *unorm2_getNFCInstance(UErrorCode *status) {
  *status = U_ZERO_ERROR;
  return NULL;
}

UBool unorm2_hasBoundaryBefore(const UNormalizer2 *norm2, UChar32 c) {
  return true;
}

UBool u_hasBinaryProperty(UChar32 ch, UProperty p) {
  switch (ch) {
  case UCHAR_ALPHABETIC:
    return unichar_isalpha(ch);
  case UCHAR_ASCII_HEX_DIGIT:
    return unichar_isxdigit(ch);
  case UCHAR_DASH:
    return ch == '-';
  case UCHAR_DEFAULT_IGNORABLE_CODE_POINT:
    return !unichar_isprint(ch);
  case UCHAR_GRAPHEME_BASE:
    return true;
  case UCHAR_HEX_DIGIT:
    return unichar_isxdigit(ch);
  case UCHAR_LOWERCASE:
    return unichar_islower(ch);
  case UCHAR_UPPERCASE:
    return unichar_isupper(ch);
  case UCHAR_QUOTATION_MARK:
    return ch == '"';
  case UCHAR_TERMINAL_PUNCTUATION:
    return ch == '.' || ch == ',';
  case UCHAR_WHITE_SPACE:
    return unichar_isspace(ch);
  case UCHAR_S_TERM:
    return ch == '.';
  case UCHAR_CHANGES_WHEN_CASEMAPPED:
  case UCHAR_CASED:
    return unichar_islower(ch) != unichar_isupper(ch);
  case UCHAR_CASE_IGNORABLE:
    return unichar_islower(ch) == unichar_isupper(ch);
  case UCHAR_CHANGES_WHEN_NFKC_CASEFOLDED:
  case UCHAR_CHANGES_WHEN_CASEFOLDED:
  case UCHAR_CHANGES_WHEN_LOWERCASED:
    return unichar_tolower(ch) != ch;
  case UCHAR_CHANGES_WHEN_TITLECASED:
  case UCHAR_CHANGES_WHEN_UPPERCASED:
    return unichar_toupper(ch) != ch;
  default:
    return false;
  }
}

int32_t u_getCharGeneralCategory(UChar32 ch) {
  if (unichar_isupper(ch))
    return U_UPPERCASE_LETTER;
  else if (unichar_islower(ch))
    return U_LOWERCASE_LETTER;
  else if (unichar_isdigit(ch))
    return U_DECIMAL_DIGIT_NUMBER;
  else if (unichar_isprint(ch))
    return U_OTHER_LETTER;
  else
    return U_UNASSIGNED;
}

int32_t u_getIntPropertyValue(UChar32 ch, UProperty prop) {
  switch (prop) {
  case UCHAR_NFC_QUICK_CHECK:
    return 1;
  case UCHAR_GENERAL_CATEGORY:
    return u_getCharGeneralCategory(ch);
  case UCHAR_CANONICAL_COMBINING_CLASS:
    return 0;
  case UCHAR_NUMERIC_TYPE:
    return unichar_isdigit(ch) ? 1 : 0;
  default:
    return -1;
  }
}

void u_charAge(UChar32 ch, UVersionInfo info) {
  info[0] = 1;
  info[1] = 0;
  info[2] = 0;
  info[3] = 0;
}

int32_t u_charName(UChar32 code, UCharNameChoice nameChoice, char *buffer,
                   int32_t bufferLength, UErrorCode *pErrorCode) {
  *pErrorCode = U_ZERO_ERROR;
  return 0; // 0 => no name
}

int32_t u_strToLower(UChar *dest, int32_t destCapacity, const UChar *src,
                     int32_t srcLength, const char *locale,
                     UErrorCode *pErrorCode) {
  for (int i = 0; i < srcLength & i < destCapacity; i++)
    dest[i] = unichar_tolower(src[i]);
  return srcLength;
}

int32_t u_strToTitle(UChar *dest, int32_t destCapacity, const UChar *src,
                     int32_t srcLength, UBreakIterator *titleIter,
                     const char *locale, UErrorCode *pErrorCode) {
  bool makeUpper = true;
  for (int i = 0; i < srcLength & i < destCapacity; i++) {
    dest[i] = makeUpper ? unichar_toupper(src[i]) : src[i];
    makeUpper = unichar_isspace(src[i]);
  }
  return srcLength;
}

int32_t u_strToUpper(UChar *dest, int32_t destCapacity, const UChar *src,
                     int32_t srcLength, const char *locale,
                     UErrorCode *pErrorCode) {
  for (int i = 0; i < srcLength & i < destCapacity; i++)
    dest[i] = unichar_toupper(src[i]);
  return srcLength;
}

double u_getNumericValue(UChar32 ch) {
  if (unichar_isxdigit(ch))
    return unichar_xdigit_value(ch);
  return U_NO_NUMERIC_VALUE;
}
