import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile {
  late final Reference ref;
  late final String name;
  late final String url;

  FirebaseFile({
      required this.ref,
      required this.name,
      required this.url
  });

}