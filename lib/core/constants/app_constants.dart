/// Core constants and metadata for the B.O.M.B study app.
class AppConstants {
  static const String appName = 'B.O.M.B';
  static const String appTagline = 'Book of Mormon & Bible Scripture Study';

  // Volume Identifiers
  static const String volumeOldTestament = 'ot';
  static const String volumeNewTestament = 'nt';
  static const String volumeBookOfMormon = 'bom';

  // Volume Display Names
  static const Map<String, String> volumeTitles = {
    volumeBookOfMormon: 'The Book of Mormon',
    volumeOldTestament: 'The Old Testament',
    volumeNewTestament: 'The New Testament',
  };
}
