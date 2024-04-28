import 'package:chat_ai/domain/entities/response/part.dart';

class Content {
  List<Parts> parts;
  String role;

  Content({
    required this.parts,
    required this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: List<Parts>.from(json["parts"].map((x) => Parts.fromJson(x))),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
        "role": role,
      };
}
