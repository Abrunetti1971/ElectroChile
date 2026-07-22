enum SecValidationStatus {
  pending,
  passed,
  warning,
  failed,
}

class SecValidation {
  final String id;
  final String category;
  final String title;
  final String description;
  final String recommendation;
  final SecValidationStatus status;
  final bool mandatory;

  const SecValidation({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.recommendation,
    required this.status,
    this.mandatory = true,
  });

  bool get isPassed => status == SecValidationStatus.passed;

  bool get isFailed => status == SecValidationStatus.failed;

  bool get isWarning => status == SecValidationStatus.warning;

  bool get isPending => status == SecValidationStatus.pending;

  SecValidation copyWith({
    String? id,
    String? category,
    String? title,
    String? description,
    String? recommendation,
    SecValidationStatus? status,
    bool? mandatory,
  }) {
    return SecValidation(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      recommendation: recommendation ?? this.recommendation,
      status: status ?? this.status,
      mandatory: mandatory ?? this.mandatory,
    );
  }
}