import 'package:flutter/material.dart';

enum Month {january, february, march, april, may, june, july, august, september,
  october, november, december}

extension MonthExtension on Month {
   String get morningImage => 'assets/Morning/$imageAsset';
   String get eveningImage => 'assets/Evening/$imageAsset';
   String get imageAsset =>
      {
        Month.january: 'Jan.jpg',
        Month.february: 'Feb.jpg',
        Month.march: 'March.jpg',
        Month.april: 'April.jpg',
        Month.may: 'May.jpg',
        Month.june: 'June.jpg',
        Month.july: 'July.jpg',
        Month.august: 'Aug.jpg',
        Month.september: 'Sept.jpg',
        Month.october: 'Oct.jpg',
        Month.november: 'Nov.jpg',
        Month.december: 'Dec.jpg',

      }[this] ??
  '';
}

class PhotoStack extends StatelessWidget {
  const PhotoStack (
  {Key? key, required this.month, required this.morningDescription}) : super(key: key);

  final Month month;
  final bool morningDescription;

  bool get hasImage => !morningDescription || month.imageAsset.isEmpty;

  @override
  Widget build(BuildContext context) => Stack(children: [
    hasImage
    ? Image(
      image: AssetImage(month.imageAsset),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.37,
      fit: BoxFit.fill,
    )
        : const SizedBox(),
    Container(

    )
  ]);

}