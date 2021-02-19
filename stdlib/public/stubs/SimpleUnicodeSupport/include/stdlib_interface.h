#ifndef STDLIB_INTERFACE_H
#define STDLIB_INTERFACE_H

#include "UCharCategory.h"
#include "UProperty.h"
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef uint16_t UChar;
typedef int32_t UChar32;
typedef int8_t UBool;

#define UBRK_DONE (-1)
#define U_NO_NUMERIC_VALUE ((double)-123456789.)

typedef enum UTextType {
  UTEXT_UTF8,
  UTEXT_UTF16,
} UTextType;

typedef struct UText {
  UTextType type;
  int64_t length;
  union {
    const UChar *utf16;
    const char *utf8;
  } code_points;
} UText;

typedef enum UBreakIteratorType {
  UBRK_CHARACTER = 0,
  UBRK_WORD = 1,
  UBRK_LINE = 2,
  UBRK_SENTENCE = 3,
  UBRK_TITLE = 4,
  UBRK_COUNT = 5
} UBreakIteratorType;

typedef struct UBreakIterator UNormalizer2;

typedef struct UBreakIterator {
  UBreakIteratorType type;
  UText *text;
} UBreakIterator;

typedef enum UErrorCode {
  U_ZERO_ERROR = 0,
  U_SOME_ERROR = 1,
} UErrorCode;

typedef enum UCharNameChoice {
  U_UNICODE_CHAR_NAME,
} UCharNameChoice;

#define U_MAX_VERSION_LENGTH 4
typedef uint8_t UVersionInfo[U_MAX_VERSION_LENGTH];

// Grapheme breaking APIs
void ubrk_close(UBreakIterator *);
UBreakIterator *ubrk_open(UBreakIteratorType, const char *, const UChar *,
                          int32_t, UErrorCode *);
int32_t ubrk_preceding(UBreakIterator *, int32_t);
int32_t ubrk_following(UBreakIterator *, int32_t);
void ubrk_setText(UBreakIterator *, const UChar *, int32_t, UErrorCode *);
void ubrk_setUText(UBreakIterator *, UText *, UErrorCode *);

UText *utext_openUTF8(UText *, const char *, int64_t, UErrorCode *);
UText *utext_openUChars(UText *, const UChar *, int64_t, UErrorCode *);

// Comparison, normalization, and character property APIs
int32_t unorm2_spanQuickCheckYes(const UNormalizer2 *norm2, const UChar *s,
                                 int32_t length, UErrorCode *status);
int32_t unorm2_normalize(const UNormalizer2 *, const UChar *, int32_t, UChar *,
                         int32_t, UErrorCode *);
const UNormalizer2 *unorm2_getNFCInstance(UErrorCode *status);
UBool unorm2_hasBoundaryBefore(const UNormalizer2 *norm2, UChar32 c);
UBool u_hasBinaryProperty(UChar32 ch, UProperty p);
void u_charAge(UChar32, UVersionInfo);
int32_t u_getIntPropertyValue(UChar32, UProperty);
int32_t u_charName(UChar32, UCharNameChoice, char *, int32_t, UErrorCode *);
int32_t u_strToLower(UChar *, int32_t, const UChar *, int32_t, const char *,
                     UErrorCode *);
int32_t u_strToTitle(UChar *, int32_t, const UChar *, int32_t, UBreakIterator *,
                     const char *, UErrorCode *);
int32_t u_strToUpper(UChar *, int32_t, const UChar *, int32_t, const char *,
                     UErrorCode *);
double u_getNumericValue(UChar32);

#ifdef __cplusplus
}
#endif

#endif // STDLIB_INTERFACE_H
