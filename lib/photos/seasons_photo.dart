import 'package:flutter/material.dart';



class DailyReadingsSeasonsPhoto extends StatefulWidget {
  const DailyReadingsSeasonsPhoto({Key? key}) : super(key: key);

  @override
  State<DailyReadingsSeasonsPhoto> createState() =>
      _DailyReadingsSeasonsPhotoState();
}

class _DailyReadingsSeasonsPhotoState extends State<DailyReadingsSeasonsPhoto> {
  String morningJanuaryUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FJan.jpg?alt=media&token=f98802d3-1c38-4e6e-9bc4-0bc89efac976';
  String morningFebruaryUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FFeb.jpg?alt=media&token=e988e387-1bea-4033-9ad9-3db09b7e8b00';
  String morningMarchUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FMarch.jpg?alt=media&token=073409c5-d4ba-4308-9a35-d97b5d1c7f9d';
  String morningAprilUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FApril.jpg?alt=media&token=8fb5f187-5310-4d1a-8a1a-2607b3fe33ba';
  String morningMayUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FMay.jpg?alt=media&token=93cb62c9-bf08-412b-8888-e247083920fe';
  String morningJuneUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FJune.jpg?alt=media&token=6632b48b-2069-41ff-9ed9-a1de820535cb';
  String morningJulyUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FJuly.jpg?alt=media&token=8e714997-a42b-42fb-9bed-7dd78335b159';
  String morningAugustUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FAug.jpg?alt=media&token=a8f9439a-c8cc-4de9-adda-56364e5f316d';
  String morningSeptemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FSept.jpg?alt=media&token=8b703948-4f17-437c-84b7-de4465d1130a';
  String morningOctoberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FOct.jpg?alt=media&token=171bea70-da2e-47c0-b86d-06d8754863ea';
  String morningNovemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FNov.jpg?alt=media&token=02182017-7c47-4338-a533-05948185cf62';
  String morningDecemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FMorning%2FDec.jpg?alt=media&token=254b1be0-4913-46d8-9910-0876507f803c';

  String eveningJanuaryUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FJan.jpg?alt=media&token=b3554c6f-18ef-4b2f-b912-e1513aad5624';
  String eveningFebruaryUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FFeb.jpg?alt=media&token=153c2e14-eb11-4e97-9209-cea137328afa';
  String eveningMarchUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FMarch.jpg?alt=media&token=d8b1c365-f2ed-4024-b757-2852b0598156';
  String eveningAprilUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FApril.jpg?alt=media&token=b2b6c729-414b-4fdc-b228-bf1f624ebeb2';
  String eveningMayUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FMay.jpg?alt=media&token=309293c8-8676-4937-b8f7-0cd438c70a88';
  String eveningJuneUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FJune.jpg?alt=media&token=948f9daa-1c90-44db-8704-c07a681fc5f7';
  String eveningJulyUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FJuly.jpg?alt=media&token=da3eb749-6ea3-4064-b75c-3d61836d422f';
  String eveningAugustUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FAugust.jpg?alt=media&token=c4c75c57-7498-4023-a12a-114a61243abe';
  String eveningSeptemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FSeptember.jpg?alt=media&token=080bc5db-db0b-4226-8c8d-bb8ca1aa5b44';
  String eveningOctoberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FOct.jpg?alt=media&token=b889b68a-cd81-4325-86e1-0ebfcac4a8eb';
  String eveningNovemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FNov.jpg?alt=media&token=5e3e1e24-3070-45b4-abe4-2e776cfc9a9a';
  String eveningDecemberUrl =
      'https://firebasestorage.googleapis.com/v0/b/daily-readings-63a7d.appspot.com/o/Photos%20for%20Daily%20Readings%2FEvening%2FDec.jpg?alt=media&token=dbf94f34-ffab-4b38-aacb-d9c5218587be';
  late String image;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
