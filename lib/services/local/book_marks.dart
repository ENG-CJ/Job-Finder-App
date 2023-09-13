import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';

class Bookmarks {
  String? key;
  String? jobTitle;
  String? company;
  String? jobDescription;

  Bookmarks({this.key, this.jobTitle, this.company, this.jobDescription});
  final _bookmarks = Hive.box('bookmark');

  factory Bookmarks.fromJson(Map<dynamic, dynamic> json) {
    return Bookmarks(
        key: json['key'],
        jobTitle: json['jobTitle'],
        company: json['company'],
        jobDescription: json['jobDescription']);
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "key": key,
      'jobTitle': jobTitle,
      'company': company,
      'jobDescription': jobDescription,
    };
  }

  Future<void> addBookmarks(Bookmarks bookmarks) async {
    await _bookmarks.add(bookmarks.toJson());
  }

  Future<void> deleteBookmarks(int key) async {
    await _bookmarks.deleteAt(key);
  }

  Future<List<Bookmarks>> getBookmarks() async {
    var bookmark = _bookmarks.keys.map((key) {
      var bookmark = _bookmarks.get(key);
      return Bookmarks.fromJson(bookmark);
    }).toList();
    return bookmark;
  }

  Future<bool> hasData(String id) async {
    var bookmark = _bookmarks.keys.map((key) {
      var bookmark = _bookmarks.get(key);
      return Bookmarks.fromJson(bookmark);
    }).toList();
    var filteredData =
        bookmark.where((bookmark) => bookmark.key == id).toList();
    return filteredData.isNotEmpty;
  }

  Future<void> clearData() async {
    _bookmarks.clear();
  }
}
