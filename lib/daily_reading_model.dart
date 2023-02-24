// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyReading {
  String? author;
  String? date;
  String? description;
  int? hymnsNumber;
  String? nameOfHymnbook;
  int? numberOfVerses;
  String? prayer;
  String? reference;
  String? referenceBook;
  String? time;
  String? title;
  String? tuneName;
  int? id;

  DailyReading(
      {this.author,
      this.date,
      this.description,
      this.hymnsNumber,
      this.nameOfHymnbook,
      this.numberOfVerses,
      this.prayer,
      this.reference,
      this.referenceBook,
      this.time,
      this.title,
      this.tuneName,
      this.id});

  DailyReading.fromJson(Map<String, dynamic> json) {
    author = json['Author'];
    date = json['Date'];
    description = json['Description'];
    hymnsNumber = json['Hymns Number'];
    nameOfHymnbook = json['Name Of Hymnbook '];
    numberOfVerses = json['Number Of Verses'];
    prayer = json['Prayer'];
    reference = json['Reference'];
    referenceBook = json['Reference Book'];
    time = json['Time'];
    title = json['Title'];
    tuneName = json['Tune Name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Author'] = author;
    data['Date'] = date;
    data['Description'] = description;
    data['Hymns Number'] = hymnsNumber;
    data['Name Of Hymnbook '] = nameOfHymnbook;
    data['Number Of Verses'] = numberOfVerses;
    data['Prayer'] = prayer;
    data['Reference'] = reference;
    data['Reference Book'] = referenceBook;
    data['Time'] = time;
    data['Title'] = title;
    data['Tune Name'] = tuneName;
    data['id'] = id;
    return data;
  }

  static List<DailyReading> listFromJson(list) {
    if (null != list) {
      return List<DailyReading>.from(list.map(DailyReading.fromJson));
    }
    return List<DailyReading>.empty();
  }

  @override
  String toString() {
    return 'DailyReading(author: $author, date: $date, description: $description, hymnsNumber: $hymnsNumber, nameOfHymnbook: $nameOfHymnbook, numberOfVerses: $numberOfVerses, prayer: $prayer, reference: $reference, referenceBook: $referenceBook, time: $time, title: $title, tuneName: $tuneName, id: $id)';
  }
}
