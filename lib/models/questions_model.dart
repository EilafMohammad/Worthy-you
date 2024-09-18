// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  final Nce? appearance;
  final Nce? socialAcceptance;
  final Nce? academicPerformance;
  final Nce? careerCompetence;

  QuestionsModel({
    this.appearance,
    this.socialAcceptance,
    this.academicPerformance,
    this.careerCompetence,
  });

  QuestionsModel copyWith({
    Nce? appearance,
    Nce? socialAcceptance,
    Nce? academicPerformance,
    Nce? careerCompetence,
  }) =>
      QuestionsModel(
        appearance: appearance ?? this.appearance,
        socialAcceptance: socialAcceptance ?? this.socialAcceptance,
        academicPerformance: academicPerformance ?? this.academicPerformance,
        careerCompetence: careerCompetence ?? this.careerCompetence,
      );

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
    appearance: json["appearance"] == null ? null : Nce.fromJson(json["appearance"]),
    socialAcceptance: json["social_acceptance"] == null ? null : Nce.fromJson(json["social_acceptance"]),
    academicPerformance: json["academic_performance"] == null ? null : Nce.fromJson(json["academic_performance"]),
    careerCompetence: json["career_competence"] == null ? null : Nce.fromJson(json["career_competence"]),
  );

  Map<String, dynamic> toJson() => {
    "appearance": appearance?.toJson(),
    "social_acceptance": socialAcceptance?.toJson(),
    "academic_performance": academicPerformance?.toJson(),
    "career_competence": careerCompetence?.toJson(),
  };
}

class Nce {
  final String? key;
  final String? scenario;
  final List<String>? questions;

  Nce({
    this.key,
    this.scenario,
    this.questions,
  });

  Nce copyWith({
    String? key,
    String? scenario,
    List<String>? questions,
  }) =>
      Nce(
        key: key ?? this.key,
        scenario: scenario ?? this.scenario,
        questions: questions ?? this.questions,
      );

  factory Nce.fromJson(Map<String, dynamic> json) => Nce(
    key: json["key"],
    scenario: json["scenario"],
    questions: json["questions"] == null ? [] : List<String>.from(json["questions"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "scenario": scenario,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x)),
  };
}
