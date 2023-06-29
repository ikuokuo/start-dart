#include "clib.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

char *greet(char *who) {
  size_t n = 10 + strlen(who);
  char *buf = (char *)malloc(n * sizeof(char));  // NOLINT
  snprintf(buf, n, "Hello, %s.", who);
  return buf;
}

void free_string(char *str) {
  free(str);
}

struct Coordinate create_coordinate(double latitude, double longitude) {
  struct Coordinate coordinate;
  coordinate.latitude = latitude;
  coordinate.longitude = longitude;
  return coordinate;
}

struct Place create_place(char *name, double latitude, double longitude) {
  struct Place place;
  place.name = name;
  place.coordinate = create_coordinate(latitude, longitude);
  return place;
}

double distance(struct Coordinate c1, struct Coordinate c2) {
  double xd = c2.latitude - c1.latitude;
  double yd = c2.longitude - c1.longitude;
  return sqrt(xd*xd + yd*yd);
}
