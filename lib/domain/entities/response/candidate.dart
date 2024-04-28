import 'package:chat_ai/domain/entities/response/content.dart';
import 'package:chat_ai/domain/entities/response/safety_ratings.dart';

class Candidate {
  Content content;
  String finishReason;
  int index;
  List<SafetyRating> safetyRatings;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.index,
    required this.safetyRatings,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        content: Content.fromJson(json["content"]),
        finishReason: json["finishReason"],
        index: json["index"],
        safetyRatings: List<SafetyRating>.from(
            json["safetyRatings"].map((x) => SafetyRating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings":
            List<dynamic>.from(safetyRatings.map((x) => x.toJson())),
      };
}
