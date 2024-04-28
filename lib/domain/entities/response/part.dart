class Parts {
  String text;

  Parts({
    required this.text,
  });

  factory Parts.fromJson(Map<String, dynamic> json) => Parts(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}
