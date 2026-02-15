import 'dart:io';

/*dart run lib/tool/generate_strings.dart
*/

String toCamelCase(String text) {
  final parts = text
      .replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '') // remove symbols
      .split(RegExp(r'\s+')) // split by space
      .where((e) => e.isNotEmpty)
      .toList();

  if (parts.isEmpty) return '';
  return parts.first.toLowerCase() +
      parts.skip(1).map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase()).join();
}


void main() {
  final inputFile = File('strings.txt');
  if (!inputFile.existsSync()) {
    print('❌ strings.txt not found. Make sure it’s in the project root.');
    return;
  }

  final lines = inputFile.readAsLinesSync().where((l) => l.trim().isNotEmpty);

  final buffer = StringBuffer()
    ..writeln('class AppStrings {')
    ..writeln('  AppStrings._();')
    ..writeln('');

  for (final line in lines) {
    final varName = toCamelCase(line);
    buffer.writeln('  static const String $varName = "$line";');
  }

  buffer
    ..writeln('')
    ..writeln('}');

  // Save output file
  final outputFile = File('lib/core/constants/app_strings.dart');
  outputFile.createSync(recursive: true);
  outputFile.writeAsStringSync(buffer.toString());

  print('✅ AppStrings generated: ${outputFile.path}');
}
