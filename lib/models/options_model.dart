import 'dart:convert';

OptionsModel optionsModelFromJson(String str) => OptionsModel.fromJson(json.decode(str));

String optionsModelToJson(OptionsModel data) => json.encode(data.toJson());

class OptionsModel {
  final Nce? appearance;
  final Nce? socialAcceptance;
  final Nce? academicPerformance;
  final Nce? careerCompetence;

  OptionsModel({
    this.appearance,
    this.socialAcceptance,
    this.academicPerformance,
    this.careerCompetence,
  });

  OptionsModel copyWith({
    Nce? appearance,
    Nce? socialAcceptance,
    Nce? academicPerformance,
    Nce? careerCompetence,
  }) =>
      OptionsModel(
        appearance: appearance ?? this.appearance,
        socialAcceptance: socialAcceptance ?? this.socialAcceptance,
        academicPerformance: academicPerformance ?? this.academicPerformance,
        careerCompetence: careerCompetence ?? this.careerCompetence,
      );

  factory OptionsModel.fromJson(Map<String, dynamic> json) => OptionsModel(
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
  final List<String>? scenario;
  final List<String>? q1;
  final List<String>? q2;
  final List<String>? q3;
  final List<String>? q4;
  final List<String>? q5;

  Nce({
    this.key,
    this.scenario,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
    this.q5,
  });

  Nce copyWith({
    String? key,
    List<String>? scenario,
    List<String>? q1,
    List<String>? q2,
    List<String>? q3,
    List<String>? q4,
    List<String>? q5,
  }) =>
      Nce(
        key: key ?? this.key,
        scenario: scenario ?? this.scenario,
        q1: q1 ?? this.q1,
        q2: q2 ?? this.q2,
        q3: q3 ?? this.q3,
        q4: q4 ?? this.q4,
        q5: q5 ?? this.q5,
      );

  factory Nce.fromJson(Map<String, dynamic> json) => Nce(
    key: json["key"],
    scenario: json["scenario"] == null ? [] : List<String>.from(json["scenario"]!.map((x) => x)),
    q1: json["Q1"] == null ? [] : List<String>.from(json["Q1"]!.map((x) => x)),
    q2: json["Q2"] == null ? [] : List<String>.from(json["Q2"]!.map((x) => x)),
    q3: json["Q3"] == null ? [] : List<String>.from(json["Q3"]!.map((x) => x)),
    q4: json["Q4"] == null ? [] : List<String>.from(json["Q4"]!.map((x) => x)),
    q5: json["Q5"] == null ? [] : List<String>.from(json["Q5"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "scenario": scenario == null ? [] : List<dynamic>.from(scenario!.map((x) => x)),
    "Q1": q1 == null ? [] : List<dynamic>.from(q1!.map((x) => x)),
    "Q2": q2 == null ? [] : List<dynamic>.from(q2!.map((x) => x)),
    "Q3": q3 == null ? [] : List<dynamic>.from(q3!.map((x) => x)),
    "Q4": q4 == null ? [] : List<dynamic>.from(q4!.map((x) => x)),
    "Q5": q5 == null ? [] : List<dynamic>.from(q5!.map((x) => x)),
  };
}
