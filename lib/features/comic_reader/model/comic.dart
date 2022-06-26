import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String id, nextId, prevId;
  final String chapter;
  final String title;
  final List<String> imageUrls;
  final int pageCount;

  const Comic({
    this.id = "",
    this.chapter = "",
    this.title = "",
    this.imageUrls = const <String>[],
    this.nextId = "",
    this.prevId = "",
    this.pageCount = 0,
  });

  Comic copyWith({
    String? id,
    String? chapter,
    String? title,
    List<String>? imageUrls,
    String? nextId,
    String? prevId,
    int? pageCount,
  }) {
    return Comic(
      id: id ?? this.id,
      chapter: chapter ?? this.chapter,
      title: title ?? this.title,
      imageUrls: imageUrls ?? this.imageUrls,
      nextId: nextId ?? this.nextId,
      prevId: prevId ?? this.prevId,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  // temporary functions below
  static Future<Comic> getComic(String id) async {
    List<String> imageUrls = [
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
      "https://manhua1035-104-250-150-12.cdnmanhua.net/50/49023/1174121/1_1810.jpg?cid=1174121&key=944ed92a004a7761bd2f8d098db4ccd7&type=1",
    ];
    return Comic(
      id: id,
      chapter: id,
      title: 'Title $id',
      imageUrls: imageUrls,
      nextId: (int.parse(id) + 1).toString(),
      prevId: (int.parse(id) - 1).toString(),
      pageCount: 7,
    );
  }

  @override
  List<Object?> get props => [id, chapter, title, imageUrls];
}
