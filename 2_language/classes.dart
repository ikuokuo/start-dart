//
//  dart 2_language/classes.dart
import 'dart:math';

// Defines the String extension method parseInt()
import 'extension/string_apis.dart';

// Also defines parseInt(), but hiding NumberParsing2
// hides that extension method.
import 'extension/string_apis_2.dart' hide NumberParsing2;

import 'extension/string_apis_3.dart' as rad;

void main(List<String> args) {
  tourClasses();
  tourConstructors();
  tourMethods();
  tourExtend();
  tourMixins();
  tourClassModifiers();
  tourEnums();
  tourExtension();
  tourCallable();
}

// Classes
//  https://dart.dev/language/classes

void tourClasses() {
  print('\n----- Classes -----');

  {
    var point = Point.origin();
    point.x = 4; // Use the setter method for x.
    assert(point.x == 4); // Use the getter method for x.
    assert(point.z == null); // Values default to null.

    print('The type of a is ${point.runtimeType}');
  }

  {
    var a = Point(2, 2);
    var b = Point(4, 4);
    var distance = Point.distanceBetween(a, b);
    assert(2.8 < distance && distance < 2.9);
    print(distance);
  }

  {
    var a = const ImmutablePoint(1, 1);
    var b = const ImmutablePoint(1, 1);

    assert(identical(a, b)); // They are the same instance!
  }
  {
    var a = const ImmutablePoint(1, 1); // Creates a constant
    var b = ImmutablePoint(1, 1); // Does NOT create a constant

    assert(!identical(a, b)); // NOT the same instance!
  }
  {
    // Only one const, which establishes the constant context.
    const pointAndLine = {
      'point': [ImmutablePoint(0, 0)],
      'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
    };
  }

  {
    String greetBob(Person person) => person.greet('Bob');

    print(greetBob(Person('Kathy')));
    print(greetBob(Impostor()));
  }
}

class Point {
  double x = 0; // Declare x, initially 0.
  double y = 0; // Declare y, initially 0.
  double? z; // Declare z, initially null.

  // Sets the x and y instance variables
  // before the constructor body runs.
  Point(this.x, this.y);

  // Named constructor
  Point.origin();

  // Initializer list sets instance variables before
  // the constructor body runs.
  Point.fromJson(Map<String, double> json)
      : x = json['x']!,
        y = json['y']! {
    print('In Point.fromJson(): ($x, $y)');
  }

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);

  Point.withAssert(this.x, this.y) : assert(x >= 0) {
    print('In Point.withAssert(): ($x, $y)');
  }

  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

// Constant constructors
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}

class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';

  String greet(String who) => 'Hi $who. Do you know who I am?';
}

// Constructors
//  https://dart.dev/language/constructors

void tourConstructors() {
  print('\n----- Constructors -----');

  {
    var employee = Employee.fromJson({});
    print(employee);
  }

  {
    var logger = Logger('UI');
    logger.log('Button clicked');

    var logMap = {'name': 'UI'};
    var loggerJson = Logger.fromJson(logMap);
  }
}

class PersonC {
  String? firstName;

  PersonC.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends PersonC {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(super.data) : super.fromJson() {
    print('in Employee');
  }
}

// Super parameters

class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);

  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}

// Factory constructors have no access to this.
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}

// Methods
//  https://dart.dev/language/methods

void tourMethods() {
  print('\n----- Methods -----');

  {
    final v = Vector(2, 3);
    final w = Vector(2, 2);

    assert(v + w == Vector(4, 5));
    assert(v - w == Vector(0, 1));
  }

  {
    var rect = Rectangle(3, 4, 20, 15);
    assert(rect.left == 3);
    rect.right = 12;
    assert(rect.left == -8);
  }
}

// Operators

class Vector {
  final int x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}

// Getters and setters

class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

// Abstract methods

abstract class Doer {
  // Define instance variables and methods...
  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  @override
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}

// Extend a class
//  https://dart.dev/language/extend

void tourExtend() {
  print('\n----- Extend -----');
}

class Television {
  void turnOn() {}

  set contrast(int value) {}
}

class SmartTelevision extends Television {
  @override
  void turnOn() {
    super.turnOn();
    print('SmartTelevision::turnOn() invoked');
  }

  @override
  set contrast(num value) {}
}

// noSuchMethod()

class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}

// Mixins
//  https://dart.dev/language/mixins

void tourMixins() {
  print('\n----- Mixins -----');
}

/*
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
*/

mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

/*
class Musician {
  // ...
}

mixin MusicalPerformer on Musician {
  // ...
}

class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
*/

// abstract mixin class

abstract mixin class Musician {
  // No 'on' clause, but an abstract method that other types must define if
  // they want to use (mix in or extend) Musician:
  void playInstrument(String instrumentName);

  void playPiano() {
    playInstrument('Piano');
  }

  void playFlute() {
    playInstrument('Flute');
  }
}

// Use Musician as a mixin
class Virtuoso with Musician {
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }
}

// Use Musician as a class
class Novice extends Musician {
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }
}

// Class modifiers
//  https://dart.dev/language/class-modifiers

void tourClassModifiers() {
  print('\n----- Class modifiers -----');
}

// abstract
/*
abstract class Vehicle {
  void moveForward(int meters);
}

// Error: Cannot be constructed
Vehicle myVehicle = Vehicle();

// Can be extended
class Car extends Vehicle {
  int passengers = 4;

  @override
  void moveForward(int meters) => throw UnimplementedError();
}

// Can be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
*/

// base
/*
base class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

// Can be constructed
Vehicle myVehicle = Vehicle();

// Can be extended
base class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: Cannot be implemented
base class MockVehicle implements Vehicle {
  @override
  void moveForward() {
    // ...
  }
}
*/

// interface
/*
interface class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

// Can be constructed
Vehicle myVehicle = Vehicle();

// ERROR: Cannot be inherited
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// Can be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
*/

// abstract interface

// final
/*
final class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

// Can be constructed
Vehicle myVehicle = Vehicle();

// ERROR: Cannot be inherited
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: Cannot be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
*/

// sealed
/*
sealed class Vehicle {}

class Car extends Vehicle {}

class Truck implements Vehicle {}

class Bicycle extends Vehicle {}

// ERROR: Cannot be instantiated
Vehicle myVehicle = Vehicle();

// Subclasses can be instantiated
Vehicle myCar = Car();

// ERROR: The switch is missing the Bicycle subtype or a default case.
String getVehicleSound(Vehicle vehicle) {
  return switch (vehicle) {
    Car() => 'vroom',
    Truck() => 'VROOOOMM',
    _ => 'unknown',
  };
}
*/

// Enums
//  https://dart.dev/language/enum

void tourEnums() {
  print('\n----- Enums -----');

  final favoriteColor = Color.blue;
  if (favoriteColor == Color.blue) {
    print('Your favorite color is blue!');
  }

  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);

  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);

  var aColor = Color.blue;

  switch (aColor) {
    case Color.red:
      print('Red as roses!');
      break;
    case Color.green:
      print('Green as grass!');
      break;
    default: // Without this, you see a WARNING.
      print(aColor); // 'Color.blue'
  }

  print(Color.blue.name); // 'blue'

  print(Vehicle.car.carbonFootprint);
}

enum Color { red, green, blue }

enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}

// Extension methods
//  https://dart.dev/language/extension-methods

void tourExtension() {
  print('\n----- Extension -----');

  {
    print('42'.padLeft(5)); // Use a String method.
    // print('42'.parseInt()); // Use an extension method.
  }

  // Static types and dynamic
  /*{
    dynamic d = '2';
    print(d.parseInt()); // Runtime exception: NoSuchMethodError
  }*/
  {
    var v = '2';
    // print(v.parseInt()); // Output: 2
  }

  // API conflicts
  {
    // Use the ParseNumbers extension from string_apis.dart.
    print(NumberParsing('42').parseInt());

    // Use the ParseNumbers extension from string_apis_3.dart.
    print(rad.NumberParsing('42').parseInt());

    // Only string_apis_3.dart has parseNum().
    print('42'.parseNum());
  }
}

// Callable objects
//  https://dart.dev/language/callable-objects

void tourCallable() {
  print('\n----- Callable objects -----');

  var wf = WannabeFunction();
  var out = wf('Hi', 'there,', 'gang');

  print(out);
}

class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}
