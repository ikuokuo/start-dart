// https://dart.dev/language
//  dart 2_language/tour.dart
import 'dart:io';

void main(List<String> args) {
  print('Hello, World! args=$args');
  tourVariables();
  tourControlFlow();
  tourFunctions();
  tourEnums();
  tourClasses();
  tourAsync();
  tourExceptions();
}

// Variables

void tourVariables() {
  print('\n----- Variables -----');
  {
    var name = 'Bob';
    print('name=${name}, type=${name.runtimeType}');
  }
  {
    // a final variable can be set only once
    final name = 'Bob'; // Without a type annotation
    final String nickname = 'Bobby';
  }
  {
    // a const variable is a compile-time constant
    const bar = 1000000; // Unit of pressure (dynes/cm2)
    const double atm = 1.01325 * bar; // Standard atmosphere
  }
  {
    // ? for nullable
    int? lineCount;
    assert(lineCount == null);
  }
  {
    // late for forward declaration, lazy initialization
    late String description;
    description = 'Feijoada!';
  }
}

// Control flow

void tourControlFlow() {
  print('\n----- Control flow -----');

  var year = DateTime.now().year;
  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];

  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  for (final object in flybyObjects) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
    if (month == 3) break;
  }

  while (year < 2016) {
    year += 1;
  }
}

// Functions

void tourFunctions() {
  print('\n----- Functions -----');

  int fibonacci(int n) {
    if (n == 0 || n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  print('fibonacci(20)=${fibonacci(20)}');

  var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
  flybyObjects.where((name) => name.contains('turn')).forEach(print);
}

// Enums

void tourEnums() {
  print('\n----- Enums -----');

  final yourPlanet = Planet.venus;

  if (!yourPlanet.isGiant) {
    print('Your planet is not a "giant planet".');
  }
}

enum PlanetType { terrestrial, gas, ice }

/// Enum that enumerates the different planets in our solar system
/// and some of their properties.
enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  // ···
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

  /// A constant generating constructor
  const Planet(
      {required this.planetType, required this.moons, required this.hasRings});

  /// All instance variables are final
  final PlanetType planetType;
  final int moons;
  final bool hasRings;

  /// Enhanced enums support getters and other methods
  bool get isGiant =>
      planetType == PlanetType.gas || planetType == PlanetType.ice;
}

// Classes

void tourClasses() {
  print('\n----- Classes -----');

  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
}

class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

// Inheritance

// Dart has single inheritance.
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

// Mixins

// Mixins are a way of reusing code in multiple class hierarchies.
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

// To add a mixin’s capabilities to a class, just extend the class with the mixin.
class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(super.name, DateTime super.launchDate);
}

// Interfaces and abstract classes

// All classes implicitly define an interface. Therefore, you can implement any class.
class MockSpaceship implements Spacecraft {
  @override
  String name;
  @override
  DateTime? launchDate;

  MockSpaceship(this.name);

  @override
  int? get launchYear => throw UnimplementedError();

  @override
  void describe() {}
}

// You can create an abstract class to be extended (or implemented) by a concrete class. Abstract classes can contain abstract methods (with empty bodies).
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

// Async

void tourAsync() {
  print('\n----- Async -----');

  const oneSecond = Duration(milliseconds: 300);

  Future<void> printWithDelay(String message) async {
    await Future.delayed(oneSecond);
    print(message);
  }

  printWithDelay('hello');

  // You can also use async*, which gives you a nice, readable way to build streams.
  Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
    for (final object in objects) {
      await Future.delayed(oneSecond);
      yield '${craft.name} flies by $object';
    }
  }

  // sleep(Duration(milliseconds: 500));
}

// Exceptions

void tourExceptions() {
  print('\n----- Exceptions -----');

  var astronauts = 1;

  if (astronauts == 0) {
    throw StateError('No astronauts.');
  }

  Future<void> describeFlybyObjects(List<String> flybyObjects) async {
    try {
      for (final object in flybyObjects) {
        var description = await File('$object.txt').readAsString();
        print(description);
      }
    } on IOException catch (e) {
      print('Could not describe object: $e');
    } finally {
      flybyObjects.clear();
    }
  }
}
