#include "clib.h"

#include <cstdio>
#include <cstdlib>

int main(int argc, char const *argv[]) {
  (void)argc;
  (void)argv;

  char who[] = "World";
  char *sentence = greet(who);
  printf("%s\n", sentence);
  free(sentence);

  return 0;
}
