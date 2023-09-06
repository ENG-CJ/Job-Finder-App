class ErrorGetter {
  String errorMessage;
  String? description;

  ErrorGetter({required this.errorMessage, this.description});

  factory ErrorGetter.fromJson(Map<String, dynamic> errorAsJson) {
    return ErrorGetter(
        errorMessage: errorAsJson['error'],
        description: errorAsJson['description']);
  }

  Map<String, dynamic> toJson() {
    return {"error": errorMessage, "description": description};
  }
}
