enum MonthAsset {
  january('Jan'),
  february('Feb'),
  march('March'),
  april('April'),
  may('May'),
  june('June'),
  july('July'),
  august('Aug'),
  september('Sept'),
  october('Oct'),
  november('Nov'),
  december('Dec');

  final String name;

  const MonthAsset(this.name);

  String get morningPath => 'assets/Morning/$name.jpeg';

  String get eveningPath => 'assets/Evening/$name.jpeg';

  String path(bool isMorning) => isMorning ? morningPath : eveningPath;
}