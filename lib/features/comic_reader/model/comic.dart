import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String id;
  final String episod;
  final String title;
  final List<String> imageUrls;
  

  const Comic({
    this.id = "",
    this.episod = "",
    this.title = "",
    this.imageUrls = const <String>[],

  });

  Comic copyWith({
    String? id,
    String? episod,
    String? title,
    List<String>? imageUrls,
    bool? isLastEpisod,
    bool? isFirstEpisod,
  }) {
    return Comic(
      id: id ?? this.id,
      episod: episod ?? this.episod,
      title: title ?? this.title,
      imageUrls: imageUrls ?? this.imageUrls,

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
        episod: id,
        title: 'Title $id',
        imageUrls: imageUrls,
        );
  }

  @override
  List<Object?> get props =>
      [id, episod, title, imageUrls];
}
