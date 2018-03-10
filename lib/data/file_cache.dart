import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

class CacheData {
  CacheData({
    @required this.lastModified,
    @required this.content,
  });

  final DateTime lastModified;
  final String content;

  CacheData.empty()
      : lastModified = null,
        content = null;

  bool get hasContent => content != null;

  bool contentFreshEnough(Duration maxStaleness) {
    if (!hasContent) {
      return false;
    }

    return new DateTime.now().difference(lastModified) < maxStaleness;
  }
}

typedef Future<File> TempFileGetter(String filename);

class FileCache {
  @visibleForTesting
  TempFileGetter tempFile = (String filename) async {
    var path = (await getTemporaryDirectory()).path;
    return new File('$path/filename');
  };

  Future<CacheData> read(String filename) async {
    var cachedFile = await tempFile(filename);

    try {
      var lastModified = await cachedFile.lastModified();
      var content = await cachedFile.readAsString();

      return new CacheData(
        lastModified: lastModified,
        content: content,
      );
    } catch (e) {
      return new CacheData.empty();
    }
  }

  Future<Null> persist(String filename, String rawContent) async {
    var cacheFile = await tempFile(filename);
    return cacheFile.writeAsString(rawContent);
  }
}
