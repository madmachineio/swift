#ifndef UNICODE_H
#define UNICODE_H

#include <stdbool.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define UTF8_IS_NONASCII(ch) ((ch)&0x80)
#define UTF8_IS_CONT(ch) (((ch)&0xC0) == 0x80)

typedef uint32_t size_t;
typedef uint8_t byte;
typedef uint32_t unichar;

uint32_t utf8_ptr_to_index(const byte *s, const byte *ptr);
bool utf8_check(const byte *p, size_t len);
unichar utf8_get_char(const byte *s);
const byte *utf8_next_char(const byte *s);
size_t utf8_charlen(const byte *str, size_t len);

bool unichar_isspace(unichar c);
bool unichar_isalpha(unichar c);
bool unichar_isprint(unichar c);
bool unichar_isdigit(unichar c);
bool unichar_isxdigit(unichar c);
bool unichar_isident(unichar c);
bool unichar_isupper(unichar c);
bool unichar_islower(unichar c);
uint32_t unichar_xdigit_value(unichar c);
unichar unichar_tolower(unichar c);
unichar unichar_toupper(unichar c);

#ifdef __cplusplus
}
#endif

#endif
