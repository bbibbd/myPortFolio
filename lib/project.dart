class Project {
  final String name;
  final String description;
  final String imageUrl;
  final String impression;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> imageUrls;
  final List<String> skills;
  final String importance;
  final List<String> category;
  final List<String> summary;

  Project({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.imageUrls,
    required this.skills,
    required this.impression,
    required this.importance,
    required this.category, required this.summary,
  });



}
