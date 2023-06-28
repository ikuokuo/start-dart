#include "clib.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *greet(char *who) {
  size_t n = 10 + strlen(who);
  char *buf = (char *)malloc(n * sizeof(char));  // NOLINT
  snprintf(buf, n, "Hello, %s.", who);
  return buf;
}
