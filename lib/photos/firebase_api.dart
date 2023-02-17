import 'package:firebase_storage/firebase_storage.dart';


class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      refs.map().toList();

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final links = await _getDownloadLinks(result.items);

    return links
        .asMap()
        .map((index, url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name: name, url: url);
    })

        .values
        .toList();

  }





  // static Future<String> uploadFile(String path, File file) async {
  //   final ref = FirebaseStorage.instance.ref(path);
  //   final task = ref.putFile(file);
  //
  //   final snapshot = await task;
  //
  //   final downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //   return downloadUrl;
  // }



}