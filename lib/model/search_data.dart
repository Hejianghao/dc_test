import 'package:json_annotation/json_annotation.dart';

part 'search_data.g.dart';

@JsonSerializable()
class SearchData {
  final String title;
  final String description;
  final String image;
  final String url;
  final String category;

  const SearchData({
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.category,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) =>
      _$SearchDataFromJson(json);
  Map<String, dynamic> toJson() => _$SearchDataToJson(this);
}
