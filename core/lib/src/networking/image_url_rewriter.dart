final _finnkinoBaseUrl = RegExp(r'https?://media.finnkino.fi');
const _imgixBaseUrl = 'https://inkino.imgix.net';
const _imgixQueryParams = '?auto=format,compress';

final notYetRated = RegExp(r'.*not.*yet.*rated.*', caseSensitive: false);

String rewriteImageUrl(String originalUrl) {
  if (originalUrl == null) {
    return null;
  }

  if (originalUrl.contains(notYetRated)) {
    /// Finnkino XML API might return a "Not yet rated" as an image url for a
    /// content age rating image. And you might know that "Not yet rated" is not
    /// a valid url.
    originalUrl = originalUrl.replaceFirst(
      notYetRated,
      'https://media.finnkino.fi/images/rating_large_Tulossa.png',
    );
  }

  return originalUrl.replaceFirst(_finnkinoBaseUrl, _imgixBaseUrl) +
      _imgixQueryParams;
}
