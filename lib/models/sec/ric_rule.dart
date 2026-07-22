enum RicRuleSeverity {
  info,
  warning,
  error,
}

class RicRule {
  final String id;
  final String title;
  final String category;
  final String description;
  final String recommendation;
  final RicRuleSeverity severity;

  const RicRule({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.recommendation,
    required this.severity,
  });

  factory RicRule.fromMap(Map<String, dynamic> map) {
    return RicRule(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      recommendation: map['recommendation'] ?? '',
      severity: RicRuleSeverity.values.firstWhere(
            (e) => e.name == map['severity'],
        orElse: () => RicRuleSeverity.warning,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'description': description,
      'recommendation': recommendation,
      'severity': severity.name,
    };
  }
}