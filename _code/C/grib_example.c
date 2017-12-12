#include <stdio.h>
#include "grib_api.h"

/*
 Simple example program that calls a GRIB API function
*/

int main() {
  long gribversion = grib_get_api_version();
  printf("This is GRIB_API version %li\n", gribversion);
  return 0;
}
