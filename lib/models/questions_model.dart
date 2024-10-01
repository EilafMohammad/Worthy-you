// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  final List<QuestionData>? questionsData;

  QuestionsModel({
    this.questionsData,
  });

  // Decoder: fromJson
  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      questionsData: (json['questionsData'] as List<dynamic>?)
          ?.map((item) => QuestionData.fromJson(item))
          .toList(),
    );
  }

  // Encoder: toJson
  Map<String, dynamic> toJson() {
    return {
      'questionsData': questionsData?.map((item) => item.toJson()).toList(),
    };
  }

  // CopyWith function
  QuestionsModel copyWith({
    List<QuestionData>? questionsData,
  }) {
    return QuestionsModel(
      questionsData: questionsData ?? this.questionsData,
    );
  }
}

class QuestionData {
  final int? id;
  final List<Data>? data;

  QuestionData({
    this.id,
    this.data,
  });

  // Decoder: fromJson
  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'] as int?,
      data: (json['data'] as List<dynamic>?)?.map((item) => Data.fromJson(item)).toList(),
    );
  }

  // Encoder: toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }

  // CopyWith function
  QuestionData copyWith({
    int? id,
    List<Data>? data,
  }) {
    return QuestionData(
      id: id ?? this.id,
      data: data ?? this.data,
    );
  }
}

class Data {
  final int? catId;
  final int? questionId;
  final String? key;
  final String? question;
  final List<Option>? options;

  Data({
    this.catId,
    this.questionId,
    this.key,
    this.question,
    this.options,
  });

  // Decoder: fromJson
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      catId: json['catId'] as int?,
      questionId: json['questionId'] as int?,
      key: json['key'] as String?,
      question: json['question'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((item) => Option.fromJson(item))
          .toList(),
    );
  }

  // Encoder: toJson
  Map<String, dynamic> toJson() {
    return {
      'catId': catId,
      'questionId': questionId,
      'key': key,
      'question': question,
      'options': options?.map((item) => item.toJson()).toList(),
    };
  }

  // CopyWith function
  Data copyWith({
    int? catId,
    int? questionId,
    String? key,
    String? question,
    List<Option>? options,
  }) {
    return Data(
      catId: catId ?? this.catId,
      questionId: questionId ?? this.questionId,
      key: key ?? this.key,
      question: question ?? this.question,
      options: options ?? this.options,
    );
  }
}

class Option {
  final int? catId;
  final int? questionId;
  final int? optionId;
  final String? option;

  Option({
    this.catId,
    this.questionId,
    this.optionId,
    this.option,
  });

  // Decoder: fromJson
  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      catId: json['catId'] as int?,
      questionId: json['questionId'] as int?,
      optionId: json['optionId'] as int?,
      option: json['option'] as String?,
    );
  }

  // Encoder: toJson
  Map<String, dynamic> toJson() {
    return {
      'catId': catId,
      'questionId': questionId,
      'optionId': optionId,
      'option': option,
    };
  }

  // CopyWith function
  Option copyWith({
    int? catId,
    int? questionId,
    int? optionId,
    String? option,
  }) {
    return Option(
      catId: catId ?? this.catId,
      questionId: questionId ?? this.questionId,
      optionId: optionId ?? this.optionId,
      option: option ?? this.option,
    );
  }
}