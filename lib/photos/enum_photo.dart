import 'package:flutter/cupertino.dart';

enum Month {january, february, march, april, may, june, july, august, september,
  october, november, december}

extension MonthExtension on Month {
   String get imageAsset =>
      {
        Month.january: 'assets/Morning/Jan.jpg',
        Month.february: 'assets/Morning/Feb.jpg',
        Month.march: 'assets/Morning/March.jpg',
        Month.april: 'assets/Morning/April.jpg',
        Month.may: 'assets/Morning/May.jpg',
        Month.june: 'assets/Morning/June.jpg',
        Month.july: 'assets/Morning/July.jpg',
        Month.august: 'assets/Morning/Aug.jpg',
        Month.september: 'assets/Morning/Sept.jpg',
        Month.october: 'assets/Morning/Oct.jpg',
        Month.november: 'assets/Morning/Nov.jpg',
        Month.december: 'assets/Morning/Dec.jpg',

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
      image: const AssetImage('assets/Morning/Jan.jpg'),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.37,
      fit: BoxFit.fill,
    )
        : const SizedBox(),
    Container(

    )
  ]);

}