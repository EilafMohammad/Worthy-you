// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  final List<QuestionsDatum>? questionsData;

  QuestionsModel({
    this.questionsData,
  });

  QuestionsModel copyWith({
    List<QuestionsDatum>? questionsData,
  }) =>
      QuestionsModel(
        questionsData: questionsData ?? this.questionsData,
      );

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
    questionsData: json["questionsData"] == null ? [] : List<QuestionsDatum>.from(json["questionsData"]!.map((x) => QuestionsDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionsData": questionsData == null ? [] : List<dynamic>.from(questionsData!.map((x) => x.toJson())),
  };
}

class QuestionsDatum {
  final Scenario? scenario;
  final List<Datum>? data;

  QuestionsDatum({
    this.scenario,
    this.data,
  });

  QuestionsDatum copyWith({
    Scenario? scenario,
    List<Datum>? data,
  }) =>
      QuestionsDatum(
        scenario: scenario ?? this.scenario,
        data: data ?? this.data,
      );

  factory QuestionsDatum.fromJson(Map<String, dynamic> json) => QuestionsDatum(
    scenario: json["scenario"] == null ? null : Scenario.fromJson(json["scenario"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "scenario": scenario?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? key;
  final String? question;
  final List<String>? options;

  Datum({
    this.key,
    this.question,
    this.options,
  });

  Datum copyWith({
    String? key,
    String? question,
    List<String>? options,
  }) =>
      Datum(
        key: key ?? this.key,
        question: question ?? this.question,
        options: options ?? this.options,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    key: json["key"],
    question: json["question"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "key":key,
    "question": question,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}

class Scenario {
  final String? question;
  final List<String>? options;

  Scenario({
    this.question,
    this.options,
  });

  Scenario copyWith({
    String? question,
    List<String>? options,
  }) =>
      Scenario(
        question: question ?? this.question,
        options: options ?? this.options,
      );

  factory Scenario.fromJson(Map<String, dynamic> json) => Scenario(
    question: json["question"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
  };
}