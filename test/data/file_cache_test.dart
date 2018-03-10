import 'dart:async';

import 'package:inkino/data/file_cache.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';

void main() {
  group('$FileCache', () {
    MockFile mockFile;
    FileCache sut;

    final List<String> filenameLog = <String>[];

    setUp(() {
      mockFile = new MockFile();

      sut = new FileCache();
      sut.tempFile = (filename) {
        filenameLog.add(filename);
        return new Future.value(mockFile);
      };

      filenameLog.clear();
    });

    test('write test', () async {
      await sut.persist('testfile.txt', 'content');

      expect(filenameLog, ['testfile.txt']);
      verify(mockFile.writeAsString('content'));
    });

    test('read test', () async {
      when(mockFile.readAsString()).thenReturn(new Future.value('content'));

      var cachedContent = await sut.read('testfile.txt');
      expect(filenameLog, ['testfile.txt']);
      expect(cachedContent.content, 'content');
    });

    test('contentFreshEnough - old content', () async {
      when(mockFile.readAsString()).thenReturn(new Future.value('content'));

      var time = new DateTime.now().subtract(const Duration(minutes: 5));
      when(mockFile.lastModified()).thenReturn(new Future.value(time));

      var content = await sut.read('testfile.txt');
      expect(content.contentFreshEnough(const Duration(minutes: 5)), false);
    });

    test('contentFreshEnough - fresh content', () async {
      when(mockFile.readAsString()).thenReturn(new Future.value('content'));

      var time = new DateTime.now();
      when(mockFile.lastModified()).thenReturn(new Future.value(time));

      var content = await sut.read('testfile.txt');
      expect(content.contentFreshEnough(const Duration(minutes: 5)), true);
    });
  });
}