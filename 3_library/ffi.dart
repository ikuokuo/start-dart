/*
C interop using dart:ffi
  https://dart.dev/guides/libraries/c-interop
Dart FFI Samples
  https://github.com/dart-lang/samples/tree/main/ffi

How to build & run

  cd start-dart/3_library/clib/
  make

  export LD_LIBRARY_PATH=`pwd`/install/lib:$LD_LIBRARY_PATH
  ./install/bin/main

  cd start-dart/
  # dart pub add path ffi
  dart pub get
  dart 3_library/ffi.dart
*/
import 'dart:ffi';
import 'dart:io' show Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' show dirname, join;

import 'util/dylib_utils.dart';

void main(List<String> args) {
  tourCalloc();
  tourClibFunc();
  tourClibStruct();
}

// https://pub.dev/packages/ffi/example
void tourCalloc() {
  print('\n----- package:ffi calloc -----');

  // Allocate and free some native memory with calloc and free.
  final pointer = calloc<Uint8>();
  pointer.value = 3;
  print(pointer.value);
  calloc.free(pointer);

  // Use the Utf8 helper to encode zero-terminated UTF-8 strings in native memory.
  final String myString = '😎👿💬';
  final Pointer<Utf8> charPointer = myString.toNativeUtf8();
  print('First byte is: ${charPointer.cast<Uint8>().value}');
  print(charPointer.toDartString());
  calloc.free(charPointer);
}

// clib: char *greet(char *who);
//  C and Dart functions have the same signature
typedef Greet = Pointer<Utf8> Function(Pointer<Utf8> who);

// clib: void free_string(char *str)
typedef FreeStringNative = Void Function(Pointer<Utf8> str);
typedef FreeString = void Function(Pointer<Utf8> str);

void tourClibFunc() {
  print('\n----- dart:ffi clib func -----');

  // Open the dynamic library
  final dylib = dlopenPlatformSpecific('clib',
      path: join(dirname(Platform.script.path), 'clib/install/lib/'));

  // Bind functions
  final greet = dylib.lookupFunction<Greet, Greet>('greet');
  final freeString =
      dylib.lookupFunction<FreeStringNative, FreeString>('free_string');

  final who = 'World';
  final whoUtf8 = who.toNativeUtf8();

  final sentenceUtf8 = greet(whoUtf8);
  final sentence = sentenceUtf8.toDartString();
  print(sentence);

  calloc.free(whoUtf8);
  // calloc.free(sentenceUtf8);
  freeString(sentenceUtf8);
}

// Example of handling a simple C struct
final class Coordinate extends Struct {
  @Double()
  external double latitude;
  @Double()
  external double longitude;
}

// Example of a complex struct (contains a string and a nested struct)
final class Place extends Struct {
  external Pointer<Utf8> name;
  external Coordinate coordinate;
}

// clib: struct Coordinate create_coordinate(double latitude, double longitude)
typedef CreateCoordinateNative = Coordinate Function(
    Double latitude, Double longitude);
typedef CreateCoordinate = Coordinate Function(
    double latitude, double longitude);

// clib: struct Place create_place(char *name, double latitude, double longitude)
typedef CreatePlaceNative = Place Function(
    Pointer<Utf8> name, Double latitude, Double longitude);
typedef CreatePlace = Place Function(
    Pointer<Utf8> name, double latitude, double longitude);

typedef DistanceNative = Double Function(Coordinate p1, Coordinate p2);
typedef Distance = double Function(Coordinate p1, Coordinate p2);

void tourClibStruct() {
  print('\n----- dart:ffi clib struct -----');

  // Open the dynamic library
  final dylib = dlopenPlatformSpecific('clib',
      path: join(dirname(Platform.script.path), 'clib/install/lib/'));

  // Bind functions

  final createCoordinate =
      dylib.lookupFunction<CreateCoordinateNative, CreateCoordinate>(
          'create_coordinate');

  final createPlace =
      dylib.lookupFunction<CreatePlaceNative, CreatePlace>('create_place');

  final distance = dylib.lookupFunction<DistanceNative, Distance>('distance');

  // Call functions

  final coordinate = createCoordinate(3.5, 4.6);
  print(
      'Coordinate is lat ${coordinate.latitude}, long ${coordinate.longitude}');

  final myHomeUtf8 = 'My Home'.toNativeUtf8();
  final place = createPlace(myHomeUtf8, 42.0, 24.0);
  final name = place.name.toDartString();
  calloc.free(myHomeUtf8);
  final coord = place.coordinate;
  print(
      'The name of my place is $name at lat ${coord.latitude}, long ${coord.longitude}');

  final dist = distance(createCoordinate(2.0, 2.0), createCoordinate(5.0, 6.0));
  print("distance between (2,2) and (5,6) = $dist");
}
