class RicArticle {
  final String id;
  final String ric;
  final String title;
  final String article;
  final String description;
  final String technicalExplanation;
  final String installerRecommendation;
  final List<String> keywords;

  const RicArticle({
    required this.id,
    required this.ric,
    required this.title,
    required this.article,
    required this.description,
    required this.technicalExplanation,
    required this.installerRecommendation,
    required this.keywords,
  });

  factory RicArticle.fromMap(Map<String, dynamic> map) {
    return RicArticle(
      id: map['id'] ?? '',
      ric: map['ric'] ?? '',
      title: map['title'] ?? '',
      article: map['article'] ?? '',
      description: map['description'] ?? '',
      technicalExplanation: map['technicalExplanation'] ?? '',
      installerRecommendation:
      map['installerRecommendation'] ?? '',
      keywords: List<String>.from(
        map['keywords'] ?? const [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ric': ric,
      'title': title,
      'article': article,
      'description': description,
      'technicalExplanation':
      technicalExplanation,
      'installerRecommendation':
      installerRecommendation,
      'keywords': keywords,
    };
  }
}