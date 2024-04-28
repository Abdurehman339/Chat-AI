import 'package:chat_ai/domain/entities/response/candidate.dart';

class ApiResponse {
  List<Candidate> candidates;

  ApiResponse({
    required this.candidates,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
      };
}
