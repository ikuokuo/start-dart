// https://dart.dev/language/libraries
//  dart 2_language/libraries.dart

// Importing only part of a library
import 'metadata.dart' show doSomething;

// Lazily loading a library
import 'metadata.dart' deferred as meta;

void main(List<String> args) {
  doSomething();
  doSomethingAsync();
}

Future<void> doSomethingAsync() async {
  await meta.loadLibrary();
  await Future.delayed(Duration(milliseconds: 300));
  meta.doSomething();
}
