// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) =>
    HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  bool? success;
  String? message;
  TotalData? data;

  HomeDataModel({
    this.success,
    this.message,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : TotalData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class TotalData {
  List<Banner>? banners;
  List<Story>? stories;

  TotalData({
    this.banners,
    this.stories,
  });

  factory TotalData.fromJson(Map<String, dynamic> json) => TotalData(
        banners: json["banners"] == null
            ? []
            : List<Banner>.from(
                json["banners"]!.map((x) => Banner.fromJson(x))),
        stories: json["stories"] == null
            ? []
            : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners == null
            ? []
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
        "stories": stories == null
            ? []
            : List<dynamic>.from(stories!.map((x) => x.toJson())),
      };
}

class Banner {
  String? id;
  dynamic name;
  String? link;
  String? image;

  Banner({
    this.id,
    this.name,
    this.link,
    this.image,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["_id"]?.toString(),
        name: json["name"],
        link: json["link"]?.toString() ?? '',
        // image: json["image"],
        image: json["image"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "link": link,
        "image": image,
      };
}

// class BannerName {
//   String? eng;
//   String? kaz;
//   String? rus;

//   BannerName({
//     this.eng,
//     this.kaz,
//     this.rus,
//   });

//   factory BannerName.fromJson(Map<String, dynamic> json) => BannerName(
//         eng: json["eng"],
//         kaz: json["kaz"],
//         rus: json["rus"],
//       );

//   Map<String, dynamic> toJson() => {
//         "eng": eng,
//         "kaz": kaz,
//         "rus": rus,
//       };
// }

class Story {
  String? id;
  dynamic name;
  Map<String, String>? file;

  Story({
    this.id,
    this.name,
    this.file,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["_id"],
        name: json["name"],
        file: (json["file"] as Map<String, dynamic>?)?.map(
          (key, value) =>
              MapEntry(key, value.toString()), // Convert values to String
        ),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "file": file,
      };
}

class FileClass {
  String? storiesCleoRossInstructionPng;
  String? storiesCleoRossLoginsPng;
  String? storiesOceanWoodardVideo3Png;
  String? storiesOceanWoodardInstructionPng;

  FileClass({
    this.storiesCleoRossInstructionPng,
    this.storiesCleoRossLoginsPng,
    this.storiesOceanWoodardVideo3Png,
    this.storiesOceanWoodardInstructionPng,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        storiesCleoRossInstructionPng:
            json["stories/cleo-ross/instruction.png"],
        storiesCleoRossLoginsPng: json["stories/cleo-ross/logins.png"],
        storiesOceanWoodardVideo3Png: json["stories/ocean-woodard/video3.png"],
        storiesOceanWoodardInstructionPng:
            json["stories/ocean-woodard/instruction.png"],
      );

  Map<String, dynamic> toJson() => {
        "stories/cleo-ross/instruction.png": storiesCleoRossInstructionPng,
        "stories/cleo-ross/logins.png": storiesCleoRossLoginsPng,
        "stories/ocean-woodard/video3.png": storiesOceanWoodardVideo3Png,
        "stories/ocean-woodard/instruction.png":
            storiesOceanWoodardInstructionPng,
      };
}

// class StoryName {
//   String? eng;
//   String? kaz;

//   StoryName({
//     this.eng,
//     this.kaz,
//   });

//   factory StoryName.fromJson(Map<String, dynamic> json) => StoryName(
//         eng: json["eng"],
//         kaz: json["kaz"],
//       );

//   Map<String, dynamic> toJson() => {
//         "eng": eng,
//         "kaz": kaz,
//       };
// }
