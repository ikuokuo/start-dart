// https://dart.dev/guides/libraries/library-tour
//  dart 3_library/tour.dart

import 'dart:async';
import 'dart:convert';
import 'dart:math';
// import 'dart:html';
import 'dart:io';

void main(List<String> args) async {
  tourCore();
  await tourAsync();
  tourMath();
  tourConvert();
  tourHtml();
  await tourIo();
}

// dart:core - numbers, collections, strings, and more

void tourCore() {
  print('\n----- dart:core -----');

  // Numbers

  {
    assert(int.parse('42') == 42);
    assert(int.parse('0x42') == 66);
    assert(double.parse('0.50') == 0.5);

    assert(num.parse('42') is int);
    assert(num.parse('0x42') is int);
    assert(num.parse('0.50') is double);

    assert(int.parse('42', radix: 16) == 66);
  }
  // Convert an int to a string.
  {
    assert(42.toString() == '42');

    // Convert a double to a string.
    assert(123.456.toString() == '123.456');

    // Specify the number of digits after the decimal.
    assert(123.456.toStringAsFixed(2) == '123.46');

    // Specify the number of significant figures.
    assert(123.456.toStringAsPrecision(2) == '1.2e+2');
    assert(double.parse('1.2e+2') == 120.0);
  }

  // Strings and regular expressions

  // Searching inside a string
  {
    // Check whether a string contains another string.
    assert('Never odd or even'.contains('odd'));

    // Does a string start with another string?
    assert('Never odd or even'.startsWith('Never'));

    // Does a string end with another string?
    assert('Never odd or even'.endsWith('even'));

    // Find the location of a string inside a string.
    assert('Never odd or even'.indexOf('odd') == 6);
  }
  // Extracting data from a string
  {
    // Grab a substring.
    assert('Never odd or even'.substring(6, 9) == 'odd');

    // Split a string using a string pattern.
    var parts = 'progressive web apps'.split(' ');
    assert(parts.length == 3);
    assert(parts[0] == 'progressive');

    // Get a UTF-16 code unit (as a string) by index.
    assert('Never odd or even'[0] == 'N');

    // Use split() with an empty string parameter to get
    // a list of all characters (as Strings); good for
    // iterating.
    for (final char in 'hello'.split('')) {
      print(char);
    }

    // Get all the UTF-16 code units in the string.
    var codeUnitList = 'Never odd or even'.codeUnits.toList();
    assert(codeUnitList[0] == 78);
  }
  // Trimming and empty strings
  {
    // Trim a string.
    assert('  hello  '.trim() == 'hello');

    // Check whether a string is empty.
    assert(''.isEmpty);

    // Strings with only white space are not empty.
    assert('  '.isNotEmpty);
  }
  // Replacing part of a string
  {
    var greetingTemplate = 'Hello, NAME!';
    var greeting = greetingTemplate.replaceAll(RegExp('NAME'), 'Bob');

    // greetingTemplate didn't change.
    assert(greeting != greetingTemplate);
  }
  // Building a string
  {
    var sb = StringBuffer();
    sb
      ..write('Use a StringBuffer for ')
      ..writeAll(['efficient', 'string', 'creation'], ' ')
      ..write('.');

    var fullString = sb.toString();

    assert(fullString == 'Use a StringBuffer for efficient string creation.');
  }
  // Regular expressions
  {
    // Here's a regular expression for one or more digits.
    var numbers = RegExp(r'\d+');

    var allCharacters = 'llamas live fifteen to twenty years';
    var someDigits = 'llamas live 15 to 20 years';

    // contains() can use a regular expression.
    assert(!allCharacters.contains(numbers));
    assert(someDigits.contains(numbers));

    // Replace every match with another string.
    var exedOut = someDigits.replaceAll(numbers, 'XX');
    assert(exedOut == 'llamas live XX to XX years');
  }
  {
    var numbers = RegExp(r'\d+');
    var someDigits = 'llamas live 15 to 20 years';

    // Check whether the reg exp has a match in a string.
    assert(numbers.hasMatch(someDigits));

    // Loop through all matches.
    for (final match in numbers.allMatches(someDigits)) {
      print(match.group(0)); // 15, then 20
    }
  }

  // Collections
  //  https://dart.dev/codelabs/iterables

  // Lists
  {
    // Create an empty list of strings.
    var grains = <String>[];
    assert(grains.isEmpty);

    // Create a list using a list literal.
    var fruits = ['apples', 'oranges'];

    // Add to a list.
    fruits.add('kiwis');

    // Add multiple items to a list.
    fruits.addAll(['grapes', 'bananas']);

    // Get the list length.
    assert(fruits.length == 5);

    // Remove a single item.
    var appleIndex = fruits.indexOf('apples');
    fruits.removeAt(appleIndex);
    assert(fruits.length == 4);

    // Remove all elements from a list.
    fruits.clear();
    assert(fruits.isEmpty);

    // You can also create a List using one of the constructors.
    var vegetables = List.filled(99, 'broccoli');
    assert(vegetables.every((v) => v == 'broccoli'));
  }
  {
    var fruits = ['apples', 'oranges'];

    // Access a list item by index.
    assert(fruits[0] == 'apples');

    // Find an item in a list.
    assert(fruits.indexOf('apples') == 0);
  }
  {
    var fruits = ['bananas', 'apples', 'oranges'];

    // Sort a list.
    fruits.sort((a, b) => a.compareTo(b));
    assert(fruits[0] == 'apples');
  }
  {
    // This list should contain only strings.
    var fruits = <String>[];

    fruits.add('apples');
    var fruit = fruits[0];
    assert(fruit is String);
  }

  // Sets
  {
    // Create an empty set of strings.
    var ingredients = <String>{};

    // Add new items to it.
    ingredients.addAll(['gold', 'titanium', 'xenon']);
    assert(ingredients.length == 3);

    // Adding a duplicate item has no effect.
    ingredients.add('gold');
    assert(ingredients.length == 3);

    // Remove an item from a set.
    ingredients.remove('gold');
    assert(ingredients.length == 2);

    // You can also create sets using
    // one of the constructors.
    var atomicNumbers = Set.from([79, 22, 54]);
  }
  {
    var ingredients = Set<String>();
    ingredients.addAll(['gold', 'titanium', 'xenon']);

    // Check whether an item is in the set.
    assert(ingredients.contains('titanium'));

    // Check whether all the items are in the set.
    assert(ingredients.containsAll(['titanium', 'xenon']));
  }
  {
    var ingredients = Set<String>();
    ingredients.addAll(['gold', 'titanium', 'xenon']);

    // Create the intersection of two sets.
    var nobleGases = Set.from(['xenon', 'argon']);
    var intersection = ingredients.intersection(nobleGases);
    assert(intersection.length == 1);
    assert(intersection.contains('xenon'));
  }

  // Maps
  {
    // Maps often use strings as keys.
    var hawaiianBeaches = {
      'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
      'Big Island': ['Wailea Bay', 'Pololu Beach'],
      'Kauai': ['Hanalei', 'Poipu']
    };

    // Maps can be built from a constructor.
    var searchTerms = Map();

    // Maps are parameterized types; you can specify what
    // types the key and value should be.
    var nobleGases = Map<int, String>();
  }
  {
    var nobleGases = {54: 'xenon'};

    // Retrieve a value with a key.
    assert(nobleGases[54] == 'xenon');

    // Check whether a map contains a key.
    assert(nobleGases.containsKey(54));

    // Remove a key and its value.
    nobleGases.remove(54);
    assert(!nobleGases.containsKey(54));
  }
  {
    var hawaiianBeaches = {
      'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
      'Big Island': ['Wailea Bay', 'Pololu Beach'],
      'Kauai': ['Hanalei', 'Poipu']
    };

    // Get all the keys as an unordered collection
    // (an Iterable).
    var keys = hawaiianBeaches.keys;

    assert(keys.length == 3);
    assert(Set.from(keys).contains('Oahu'));

    // Get all the values as an unordered collection
    // (an Iterable of Lists).
    var values = hawaiianBeaches.values;
    assert(values.length == 3);
    assert(values.any((v) => v.contains('Waikiki')));
  }
  {
    var hawaiianBeaches = {
      'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
      'Big Island': ['Wailea Bay', 'Pololu Beach'],
      'Kauai': ['Hanalei', 'Poipu']
    };

    assert(hawaiianBeaches.containsKey('Oahu'));
    assert(!hawaiianBeaches.containsKey('Florida'));
  }
  /*{
    var teamAssignments = <String, String>{};
    teamAssignments.putIfAbsent('Catcher', () => pickToughestKid());
    assert(teamAssignments['Catcher'] != null);
  }*/

  // Common collection methods
  {
    var coffees = <String>[];
    var teas = ['green', 'black', 'chamomile', 'earl grey'];
    assert(coffees.isEmpty);
    assert(teas.isNotEmpty);
  }
  {
    var teas = ['green', 'black', 'chamomile', 'earl grey'];

    teas.forEach((tea) => print('I drink $tea'));
  }
  {
    var hawaiianBeaches = {
      'Oahu': ['Waikiki', 'Kailua', 'Waimanalo'],
      'Big Island': ['Wailea Bay', 'Pololu Beach'],
      'Kauai': ['Hanalei', 'Poipu']
    };

    hawaiianBeaches.forEach((k, v) {
      print('I want to visit $k and swim at $v');
      // I want to visit Oahu and swim at
      // [Waikiki, Kailua, Waimanalo], etc.
    });
  }
  {
    var teas = ['green', 'black', 'chamomile', 'earl grey'];

    // The object returned by map() is an Iterable that’s lazily evaluated: your function isn’t called until you ask for an item from the returned object.
    var loudTeas = teas.map((tea) => tea.toUpperCase());
    loudTeas.forEach(print);

    {
      // To force your function to be called immediately on each item,
      var loudTeas = teas.map((tea) => tea.toUpperCase()).toList();
    }
  }
  {
    var teas = ['green', 'black', 'chamomile', 'earl grey'];

    // Chamomile is not caffeinated.
    bool isDecaffeinated(String teaName) => teaName == 'chamomile';

    // Use where() to find only the items that return true
    // from the provided function.
    var decaffeinatedTeas = teas.where((tea) => isDecaffeinated(tea));
    // or teas.where(isDecaffeinated)

    // Use any() to check whether at least one item in the
    // collection satisfies a condition.
    assert(teas.any(isDecaffeinated));

    // Use every() to check whether all the items in a
    // collection satisfy a condition.
    assert(!teas.every(isDecaffeinated));
  }

  // URIs

  // Encoding and decoding fully qualified URIs
  {
    var uri = 'https://example.org/api?foo=some message';

    var encoded = Uri.encodeFull(uri);
    assert(encoded == 'https://example.org/api?foo=some%20message');

    var decoded = Uri.decodeFull(encoded);
    assert(uri == decoded);
  }
  // Encoding and decoding URI components
  {
    var uri = 'https://example.org/api?foo=some message';

    var encoded = Uri.encodeComponent(uri);
    assert(encoded == 'https%3A%2F%2Fexample.org%2Fapi%3Ffoo%3Dsome%20message');

    var decoded = Uri.decodeComponent(encoded);
    assert(uri == decoded);
  }
  // Parsing URIs
  {
    var uri = Uri.parse('https://example.org:8080/foo/bar#frag');

    assert(uri.scheme == 'https');
    assert(uri.host == 'example.org');
    assert(uri.path == '/foo/bar');
    assert(uri.fragment == 'frag');
    assert(uri.origin == 'https://example.org:8080');
  }
  // Building URIs
  {
    var uri = Uri(
        scheme: 'https',
        host: 'example.org',
        path: '/foo/bar',
        fragment: 'frag',
        queryParameters: {'lang': 'dart'});
    assert(uri.toString() == 'https://example.org/foo/bar?lang=dart#frag');

    var httpUri = Uri.http('example.org', '/foo/bar', {'lang': 'dart'});
    var httpsUri = Uri.https('example.org', '/foo/bar', {'lang': 'dart'});

    assert(httpUri.toString() == 'http://example.org/foo/bar?lang=dart');
    assert(httpsUri.toString() == 'https://example.org/foo/bar?lang=dart');
  }

  // Dates and times

  {
    // Get the current date and time.
    var now = DateTime.now();

    // Create a new DateTime with the local time zone.
    var y2k = DateTime(2000); // January 1, 2000

    // Specify the month and day.
    y2k = DateTime(2000, 1, 2); // January 2, 2000

    // Specify the date as a UTC time.
    y2k = DateTime.utc(2000); // 1/1/2000, UTC

    // Specify a date and time in ms since the Unix epoch.
    y2k = DateTime.fromMillisecondsSinceEpoch(946684800000, isUtc: true);

    // Parse an ISO 8601 date in the UTC time zone.
    y2k = DateTime.parse('2000-01-01T00:00:00Z');

    // Create a new DateTime from an existing one, adjusting just some properties:
    var sameTimeLastYear = now.copyWith(year: now.year - 1);
  }
  {
    // 1/1/2000, UTC
    var y2k = DateTime.utc(2000);
    assert(y2k.millisecondsSinceEpoch == 946684800000);

    // 1/1/1970, UTC
    var unixEpoch = DateTime.utc(1970);
    assert(unixEpoch.millisecondsSinceEpoch == 0);
  }
  {
    var y2k = DateTime.utc(2000);

    // Add one year.
    var y2001 = y2k.add(const Duration(days: 366));
    assert(y2001.year == 2001);

    // Subtract 30 days.
    var december2000 = y2001.subtract(const Duration(days: 30));
    assert(december2000.year == 2000);
    assert(december2000.month == 12);

    // Calculate the difference between two dates.
    // Returns a Duration object.
    var duration = y2001.difference(y2k);
    assert(duration.inDays == 366); // y2k was a leap year.
  }

  // Utility classes

  // Comparing objects
  {
    var short = const Line(1);
    var long = const Line(100);
    assert(short.compareTo(long) < 0);
  }
  // Implementing map keys
  {
    var p1 = Person('Bob', 'Smith');
    var p2 = Person('Bob', 'Smith');
    var p3 = 'not a person';
    assert(p1.hashCode == p2.hashCode);
    assert(p1 == p2);
    assert(p1 != p3);
  }
  // Iteration
  //  https://dart.dev/codelabs/iterables
  /*{
    class Process {
      // Represents a process...
    }

    class ProcessIterator implements Iterator<Process> {
      @override
      Process get current => ...
      @override
      bool moveNext() => ...
    }

    // A mythical class that lets you iterate through all
    // processes. Extends a subclass of [Iterable].
    class Processes extends IterableBase<Process> {
      @override
      final Iterator<Process> iterator = ProcessIterator();
    }

    void main() {
      // Iterable objects can be used with for-in.
      for (final process in Processes()) {
        // Do something with the process.
      }
    }
  }*/

  // Exceptions

  /*{
    class FooException implements Exception {
      final String? msg;

      const FooException([this.msg]);

      @override
      String toString() => msg ?? 'FooException';
    }
  }*/

  // Weak references and finalizers
}

class Line implements Comparable<Line> {
  final int length;
  const Line(this.length);

  @override
  int compareTo(Line other) => length - other.length;
}

class Person {
  final String firstName, lastName;

  Person(this.firstName, this.lastName);

  // Override hashCode using the static hashing methods
  // provided by the `Object` class.
  @override
  int get hashCode => Object.hash(firstName, lastName);

  // You should generally implement operator `==` if you
  // override `hashCode`.
  @override
  bool operator ==(Object other) {
    return other is Person &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }
}

// dart:async - asynchronous programming
//  https://dart.dev/codelabs/async-await

Future<void> tourAsync() async {
  print('\n----- dart:async -----');

  // Future

  // Using await
  /*{
    Future<void> runUsingAsyncAwait() async {
      // ...
      var entryPoint = await findEntryPoint();
      try {
        var exitCode = await runExecutable(entryPoint, args);
        await flushThenExit(exitCode);
      } catch (e) {
        // Handle the error...
      }
      await flushThenExit(exitCode);
    }
  }
  */
  // Basic usage
  /*{
    HttpRequest.getString(url).then((String result) {
      print(result);
    }).catchError((e) {
      // Handle or ignore the error.
    });
  }*/
  // Chaining multiple asynchronous methods
  /*{
    Future result = costlyQuery(url);
    result
        .then((value) => expensiveWork(value))
        .then((_) => lengthyComputation())
        .then((_) => print('Done!'))
        .catchError((exception) {
      /* Handle exception... */
    });

    try {
      final value = await costlyQuery(url);
      await expensiveWork(value);
      await lengthyComputation();
      print('Done!');
    } catch (e) {
      /* Handle exception... */
    }
  }*/
  // Waiting for multiple futures
  {
    Future<void> deleteLotsOfFiles() async => {};
    Future<void> copyLotsOfFiles() async => {};
    Future<void> checksumLotsOfOtherFiles() async => {};

    await Future.wait([
      deleteLotsOfFiles(),
      copyLotsOfFiles(),
      checksumLotsOfOtherFiles(),
    ]);
    print('Done with all the long steps!');
  }
  // Handling errors for multiple futures
  {
    Future<void> delete() async => {};
    Future<void> copy() async => {};
    Future<void> errorResult() async => {};

    try {
      // Wait for each future in a list, returns a list of futures:
      var results = await [delete(), copy(), errorResult()].wait;
    } on ParallelWaitError<List<bool?>, List<AsyncError?>> catch (e) {
      print(e.values[0]); // Prints successful future
      print(e.values[1]); // Prints successful future
      print(e.values[2]); // Prints null when the result is an error

      print(e.errors[0]); // Prints null when the result is succesful
      print(e.errors[1]); // Prints null when the result is succesful
      print(e.errors[2]); // Prints error
    }
  }
  {
    Future<int> delete() async => Future(() => 0);
    Future<String> copy() async => Future(() => '');
    Future<bool> errorResult() async => Future(() => true);

    try {
      // Wait for each future in a record, returns a record of futures:
      (int, String, bool) result = await (delete(), copy(), errorResult()).wait;

      // Do something with the results:
      var deleteInt = result.$1;
      var copyString = result.$2;
      var errorBool = result.$3;
    } on ParallelWaitError<(int?, String?, bool?),
        (AsyncError?, AsyncError?, AsyncError?)> catch (e) {
      // ...
    }
  }

  // Stream

  // Using an asynchronous for loop
  /*{
    if (await FileSystemEntity.isDirectory(searchPath)) {
      final startingDir = Directory(searchPath);
      await for (final entity in startingDir.list()) {
        if (entity is File) {
          searchFile(entity, searchTerms);
        }
      }
    } else {
      searchFile(File(searchPath), searchTerms);
    }
  }*/
  // Listening for stream data
  /*{
    // Add an event handler to a button.
    submitButton.onClick.listen((e) {
      // When the button is clicked, it runs this code.
      submitData();
    });
  }*/
  // Transforming stream data
  /*{
    var lines =
        inputStream.transform(utf8.decoder).transform(const LineSplitter());
  }*/
  // Handling errors and completion
  /*{
    Future<void> readFileAwaitFor() async {
      var config = File('config.txt');
      Stream<List<int>> inputStream = config.openRead();

      var lines =
          inputStream.transform(utf8.decoder).transform(const LineSplitter());
      try {
        await for (final line in lines) {
          print('Got ${line.length} characters from stream');
        }
        print('file is now closed');
      } catch (e) {
        print(e);
      }
    }

    var config = File('config.txt');
    Stream<List<int>> inputStream = config.openRead();

    inputStream.transform(utf8.decoder).transform(const LineSplitter()).listen(
        (String line) {
      print('Got ${line.length} characters from stream');
    }, onDone: () {
      print('file is now closed');
    }, onError: (e) {
      print(e);
    });
  }*/
}

// dart:math - math and random

void tourMath() {
  print('\n----- dart:math -----');

  // Trigonometry
  {
    // Cosine
    assert(cos(pi) == -1.0);

    // Sine
    var degrees = 30;
    var radians = degrees * (pi / 180);
    // radians is now 0.52359.
    var sinOf30degrees = sin(radians);
    // sin 30° = 0.5
    assert((sinOf30degrees - 0.5).abs() < 0.01);
  }

  // Maximum and minimum
  {
    assert(max(1, 1000) == 1000);
    assert(min(1, -1000) == -1000);
  }

  // Math constants
  {
    // See the Math library for additional constants.
    print(e); // 2.718281828459045
    print(pi); // 3.141592653589793
    print(sqrt2); // 1.4142135623730951
  }

  // Random numbers
  {
    var random = Random();
    random.nextDouble(); // Between 0.0 and 1.0: [0, 1)
    random.nextInt(10); // Between 0 and 9.
    random.nextBool(); // true or false
  }
}

// dart:convert - decoding and encoding JSON, UTF-8, and more

void tourConvert() {
  print('\n----- dart:convert -----');

  // Decoding and encoding JSON
  {
    // NOTE: Be sure to use double quotes ("),
    // not single quotes ('), inside the JSON string.
    // This string is JSON, not Dart.
    var jsonString = '''
      [
        {"score": 40},
        {"score": 80}
      ]
    ''';

    var scores = jsonDecode(jsonString);
    assert(scores is List);

    var firstScore = scores[0];
    assert(firstScore is Map);
    assert(firstScore['score'] == 40);
  }
  {
    var scores = [
      {'score': 40},
      {'score': 80},
      {'score': 100, 'overtime': true, 'special_guest': null}
    ];

    var jsonText = jsonEncode(scores);
    assert(jsonText ==
        '[{"score":40},{"score":80},'
            '{"score":100,"overtime":true,'
            '"special_guest":null}]');
  }

  // Decoding and encoding UTF-8 characters

  List<int> utf8Bytes = [
    0xc3,
    0x8e,
    0xc3,
    0xb1,
    0xc5,
    0xa3,
    0xc3,
    0xa9,
    0x72,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xc3,
    0xb6,
    0xc3,
    0xb1,
    0xc3,
    0xa5,
    0xc4,
    0xbc,
    0xc3,
    0xae,
    0xc5,
    0xbe,
    0xc3,
    0xa5,
    0xc5,
    0xa3,
    0xc3,
    0xae,
    0xe1,
    0xbb,
    0x9d,
    0xc3,
    0xb1
  ];
  {
    var funnyWord = utf8.decode(utf8Bytes);

    assert(funnyWord == 'Îñţérñåţîöñåļîžåţîờñ');
  }
  /*{
    var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
    try {
      await for (final line in lines) {
        print('Got ${line.length} characters from stream');
      }
      print('file is now closed');
    } catch (e) {
      print(e);
    }
  }*/
  {
    List<int> encoded = utf8.encode('Îñţérñåţîöñåļîžåţîờñ');

    assert(encoded.length == utf8Bytes.length);
    for (int i = 0; i < encoded.length; i++) {
      assert(encoded[i] == utf8Bytes[i]);
    }
  }
}

// dart:html - browser-based apps
//  Only web apps can use dart:html, not command-line apps.

void tourHtml() {
  print('\n----- dart:html -----');
}

// dart:io - I/O for servers and command-line apps
//  Only non-web Flutter apps, command-line scripts, and servers can import and use dart:io, not web apps.

Future<void> tourIo() async {
  print('\n----- dart:io -----');

  // Files and directories

  // Reading a file as text
  {
    var config = File('data/config.txt');

    // Put the whole file in a single string.
    var stringContents = await config.readAsString();
    print('The file is ${stringContents.length} characters long.');

    // Put each line of the file into its own string.
    var lines = await config.readAsLines();
    print('The file is ${lines.length} lines long.');
  }

  // Reading a file as binary
  {
    var config = File('data/config.txt');

    var contents = await config.readAsBytes();
    print('The file is ${contents.length} bytes long.');
  }

  // Handling errors
  {
    var config = File('config.txt');
    try {
      var contents = await config.readAsString();
      print(contents);
    } catch (e) {
      print(e);
    }
  }

  // Streaming file contents
  {
    var config = File('data/config.txt');
    Stream<List<int>> inputStream = config.openRead();

    var lines = utf8.decoder.bind(inputStream).transform(const LineSplitter());
    try {
      await for (final line in lines) {
        print('Got ${line.length} characters from stream');
      }
      print('file is now closed');
    } catch (e) {
      print(e);
    }
  }

  // Writing file contents
  {
    var logFile = File('log.txt');
    var sink = logFile.openWrite();
    // var sink = logFile.openWrite(mode: FileMode.append);
    sink.write('FILE ACCESSED ${DateTime.now()}\n');
    await sink.flush();
    await sink.close();
  }

  // Listing files in a directory
  {
    var dir = Directory('data');

    try {
      var dirList = dir.list();
      await for (final FileSystemEntity f in dirList) {
        if (f is File) {
          print('Found file ${f.path}');
        } else if (f is Directory) {
          print('Found dir ${f.path}');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // HTTP clients and servers

  // HTTP server
  //  dart 3_library/http/http_server.dart

  // HTTP client
  //  dart 3_library/http/http_client.dart
}
