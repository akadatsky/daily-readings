import 'package:xml/xml.dart';

class Bible {
  late List<Book> books;

  Future<void> load(String xmlData) async {
    final document = XmlDocument.parse(xmlData);
    books = document
        .findAllElements('book')
        .map((node) => Book.fromXmlNode(node))
        .toList();
  }
}

class Book {
  late final String name;
  late final List<Chapter> chapters;

  Book.fromXmlNode(XmlElement node) {
    name = node.getAttribute('name')!;
    chapters = node
        .findAllElements('chapter')
        .map((node) => Chapter.fromXmlNode(node))
        .toList();
  }
}

class Chapter {
  late final int number;
  late final List<Verse> verses;

  Chapter.fromXmlNode(XmlElement node) {
    number = int.parse(node.getAttribute('number')!);
    verses = node
        .findAllElements('verse')
        .map((node) => Verse.fromXmlNode(node))
        .toList();
  }
}

class Verse {
  late final int number;
  late final String text;

  Verse.fromXmlNode(XmlElement node) {
    number = int.parse(node.getAttribute('number')!);
    text = node.text;
  }
}
