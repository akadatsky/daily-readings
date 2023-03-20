import 'package:flutter/cupertino.dart';

enum Month {january, february, march, april, may, june, july, august, september,
  october, november, december}

extension MonthExtension on Month {
   String get imageAsset =>
      {
        Month.january: 'assets/Morning/Jan.jpg',
        Month.february: 'assets/Morning/Jan.jpg',
        Month.march: 'assets/Morning/Jan.jpg',
        Month.april: 'assets/Morning/Jan.jpg',
        Month.may: 'assets/Morning/Jan.jpg',
        Month.june: 'assets/Morning/Jan.jpg',
        Month.july: 'assets/Morning/Jan.jpg',
        Month.august: 'assets/Morning/Jan.jpg',
        Month.september: 'assets/Morning/Jan.jpg',
        Month.october: 'assets/Morning/Jan.jpg',
        Month.november: 'assets/Morning/Jan.jpg',
        Month.december: 'assets/Morning/Jan.jpg',

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