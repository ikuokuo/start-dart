#pragma once

#ifdef __cplusplus
extern "C" {
#endif

char *greet(char *who);

void free_string(char *str);

struct Coordinate {
  double latitude;
  double longitude;
};

struct Place {
  char *name;
  struct Coordinate coordinate;
};

struct Coordinate create_coordinate(double latitude, double longitude);
struct Place create_place(char *name, double latitude, double longitude);

double distance(struct Coordinate, struct Coordinate);

#ifdef __cplusplus
}
#endif
