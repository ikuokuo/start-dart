// https://dart.dev/language/concurrency
//  dart 2_language/concurrency.dart

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

void main(List<String> args) async {
  await tourAsynchrony();
  await tourIsolates();
}

// Asynchrony support
//  https://dart.dev/language/async

Future<void> tourAsynchrony() async {
  print('\n----- Asynchrony support -----');

  Future<String> lookUpVersion() async {
    return Future<String>.delayed(Duration(milliseconds: 100), () => "1.0.0");
  }

  Future<void> checkVersion() async {
    var version = await lookUpVersion();
    // Do something with version
  }

  try {
    var version = await lookUpVersion();
    print(version);
  } catch (e) {
    // React to inability to look up the version
  }

  {
    await checkVersion();
    print('In main: version is ${await lookUpVersion()}');
  }

  /*{
    await for (final request in requestServer) {
      handleRequest(request);
    }
  }*/
}

// Isolates
//  https://dart.dev/language/concurrency

Future<void> tourIsolates() async {
  print('\n----- Isolates support -----');

  const filename = 'data/books.json';

  {
    Future<String> _readFileAsync() async {
      final file = File(filename);
      final contents = await file.readAsString();
      return contents.trim();
    }

    // Read some data.
    final fileData = await _readFileAsync();
    final jsonData = jsonDecode(fileData);

    // Use that data.
    print('Number of JSON keys: ${jsonData.length}');
  }

  {
    Future<Map<String, dynamic>> _readAndParseJson() async {
      final fileData = await File(filename).readAsString();
      final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
      return jsonData;
    }

    // Read some data.
    final jsonData = await Isolate.run(_readAndParseJson);

    // Use that data.
    print('Number of JSON keys: ${jsonData.length}');
  }

  {
    // Read some data.
    final jsonData = await Isolate.run(() async {
      final fileData = await File(filename).readAsString();
      final jsonData = jsonDecode(fileData) as Map<String, dynamic>;
      return jsonData;
    });

    // Use that data.
    print('Number of JSON keys: ${jsonData.length}');
  }
}

// how to spawn a long-running isolate that receives and sends messages multiple times between isolates
//  https://github.com/dart-lang/samples/tree/main/isolates/bin/long_running_isolate.dart
