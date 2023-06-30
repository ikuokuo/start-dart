/*
C interop using dart:ffi
  https://dart.dev/guides/libraries/c-interop
package:ffigen
  https://pub.dev/packages/ffigen

How to build & run

  cd start-dart/3_library/clib/
  make

  export LD_LIBRARY_PATH=`pwd`/install/lib:$LD_LIBRARY_PATH
  ./install/bin/main

  cd start-dart/
  dart pub add ffi
  dart pub add -d ffigen
  sudo apt-get install libclang-dev

  dart run ffigen --config 3_library/clib/config.yaml

  cd start-dart/
  dart 3_library/ffigen.dart
*/
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' show dirname, join;

import 'clib/clib.dart';
import 'util/dylib_utils.dart';

void main(List<String> args) {
  final dylib = dlopenPlatformSpecific('clib',
      path: join(dirname(Platform.script.path), 'clib/install/lib/'));

  final clib = CLib(dylib);

  final coordinate = clib.create_coordinate(3.5, 4.6);
  print(
      'Coordinate is lat ${coordinate.latitude}, long ${coordinate.longitude}');

  final myHomeUtf8 = 'My Home'.toNativeUtf8();
  final place = clib.create_place(myHomeUtf8.cast(), 42.0, 24.0);
  final name = place.name.cast<Utf8>().toDartString();
  calloc.free(myHomeUtf8);
  final coord = place.coordinate;
  print(
      'The name of my place is $name at lat ${coord.latitude}, long ${coord.longitude}');

  final dist = clib.distance(
      clib.create_coordinate(2.0, 2.0), clib.create_coordinate(5.0, 6.0));
  print("distance between (2,2) and (5,6) = $dist");
}
