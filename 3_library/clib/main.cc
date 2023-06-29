#include "clib.h"

#include <cstdio>
#include <cstdlib>

int main(int argc, char const *argv[]) {
  (void)argc;
  (void)argv;

  {
    char who[] = "World";
    char *sentence = greet(who);
    printf("%s\n", sentence);
    free(sentence);
  }

  {
    auto coordinate = create_coordinate(3.5, 4.6);
    printf("Coordinate is lat %.2f, long %.2f\n", coordinate.latitude, coordinate.longitude);


    char home[] = "My Home";
    auto place = create_place(home, 42.0, 24.0);
    printf("The name of my place is %s at lat %.2f, long %.2f\n",
      place.name, place.coordinate.latitude, place.coordinate.longitude);

    auto dist = distance(create_coordinate(2.0, 2.0), create_coordinate(5.0, 6.0));
    printf("distance between (2,2) and (5,6) = %.2f\n", dist);
  }

  return 0;
}
